class Oystercard

  MAX_BALANCE = 90
  MIN_CHARGE = 1
  ERR_MAX_BALANCE = "Maximum balance exceeded".freeze
  ERR_NO_MONEY = "Insufficient balance".freeze

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise ERR_MAX_BALANCE if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    @entry_station = entry_station
    raise ERR_NO_MONEY if balance < MIN_CHARGE
  end

  def touch_out(exit_station)
    @entry_station = nil
    deduct(MIN_CHARGE)
  end

  private

    def deduct(fare)
      @balance -= fare
    end
end
