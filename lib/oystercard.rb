class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :starting_station, :ending_station, :history

  def initialize
    @balance = 0
		@starting_station = nil
		@history = {}
	end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end

  def in_journey?
  	!!starting_station
  end

  def touch_in(starting_station)
		raise "Insufficient balance for journey" if balance < MINIMUM_FARE
  	@starting_station = starting_station
		@history[:starting_station] = starting_station
  end

  def touch_out(ending_station)
		deduct(MINIMUM_FARE)
		@starting_station = nil
		@ending_station = ending_station
		@history[:ending_station] = ending_station
  end

  private

	attr_reader :status

	def deduct(money)
  	@balance -= money
  end

end
