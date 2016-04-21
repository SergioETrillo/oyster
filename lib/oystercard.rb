require_relative 'journey'

class Oystercard
	MAXIMUM_BALANCE = 90
	MINIMUM_FARE = 1

	attr_reader :balance, :journey

  def initialize(journey = Journey.new)
    @balance = 0
		@starting_station = nil
		@journey = journey
	end

  def top_up(money)
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end

  # def in_journey?
  # 	!!starting_station #from Journey class
  # end

  def touch_in(station)
		raise "Insufficient balance for journey" if balance < MINIMUM_FARE
		@journey.start_journey(station)
		# @starting_station = station #push to Journey class
		# @history[:starting_station] = starting_station
  end

  def touch_out(station)
    @journey.end_journey(station)
		deduct(@journey.fare)
    p "current: #{@journey.current}"
		#@starting_station = nil
		@journey.end_journey(station)
		# @ending_station = station #push to Journey class
		# @history[:ending_station] = ending_station
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
