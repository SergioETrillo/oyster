class Oystercard

  MAX_BALANCE = 90
  MIN_CHARGE = 1
  ERR_MAX_BALANCE = "Maximum balance exceeded".freeze
  ERR_NO_MONEY = "Insufficient balance".freeze

  attr_reader :balance, :entry_station, :journeys, :journey

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
    @journey = Hash.new
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
    journey[:entry_station] = entry_station
  end

  def touch_out(exit_station)
    @entry_station = nil
    deduct(MIN_CHARGE)
    journey[:exit_station] = exit_station
    journeys << journey
  end

  private

    def deduct(fare)
      @balance -= fare
    end
end
