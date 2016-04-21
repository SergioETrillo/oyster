class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :journey, :journeylog, :previous_action

  def initialize(journeylog = JourneyLog.new)
    @previous_action = nil
    @balance = 0
		@journeylog = journeylog
    @journey = journeylog.journey
	end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end

  def touch_in(station)
		raise "Insufficient balance for journey" if balance < MINIMUM_FARE
    if previous_action == :out || previous_action == nil
      @journey.start_journey(station)
    else
      @journeylog.update_history(journey.current)
      deduct(@journey.fare)
      @journey.start_journey(station)
    end
    @previous_action = :in
  end

  def touch_out(station)
    @journey.end_journey(station)
    @journeylog.update_history(journey.current)
    deduct(@journey.fare)
    @previous_action = :out
  end

	private

	def deduct(money)
  	@balance -= money
  end

	def start_journey(station)
    journey.start_journey(station)
  end

  def end_journey(station)
    journey.end_journey(station)
  end

end
