class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :journey, :journeylog, :previous_action

  def initialize(journeylog = JourneyLog.new)   #another option: initialize journeylog object, and initialize journey object to decouple both object, no need to make dependency, ==> update_history(journey)
    @previous_action = :out
    @balance = 0
		@journeylog = journeylog
    @journey = journeylog.journey
	end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += money
  end

  def touch_in(station)
		raise "Insufficient balance for journey" if balance < MINIMUM_FARE

    if previous_action == :in
      @journeylog.update_history(@journey.current)
      deduct(@journey.fare)
    end

    @journey.start_journey(station)
    @previous_action = :in
  end

  def touch_out(station)
    @journey.end_journey(station)
    @journeylog.update_history(@journey.current)
    deduct(@journey.fare)
    @journey.clean
    @previous_action = :out
end

	private

	def deduct(money)
  	@balance -= money
  end
end
