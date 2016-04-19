class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :starting_station

  def initialize
    @balance = 0
   
  end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end

  def in_journey?
  	!!starting_station 
  end

  def touch_in(station)
		raise "Insufficient balance for journey" if balance < MINIMUM_FARE
  	@starting_station = station
  end

  def touch_out
		deduct(MINIMUM_FARE)
		@starting_station = nil
  end

  private

	attr_reader :status

	def deduct(money)
  	@balance -= money
  end

end
