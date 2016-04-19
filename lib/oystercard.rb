class Oystercard

  MAX_BALANCE = 90
  MIN_CHARGE = 1
  ERR_MAX_BALANCE = "Maximum balance exceeded".freeze
  ERR_NO_MONEY = "Insufficient balance".freeze

  attr_reader :balance, :entry_station, :journeys
  attr_accessor :current_journey



  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
    @current_journey = Hash.new
  end

  def top_up(amount)
    raise ERR_MAX_BALANCE if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    raise ERR_NO_MONEY if balance < MIN_CHARGE
    @entry_station = entry_station
    #current_journey[entry_station] = "pending"
  end

  def touch_out(exit_station)
    @entry_station = nil
    deduct(MIN_CHARGE)
    current_journey[entry_station] = exit_station
    journeys << current_journey
  end

  private

    def deduct(fare)
      @balance -= fare
    end
end
