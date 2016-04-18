class Oystercard

  MAX_BALANCE = 90
  MIN_CHARGE = 1
  ERR_MAX_BALANCE = "Maximum balance exceeded".freeze
  ERR_NO_MONEY = "Insufficient balance to touch in".freeze
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise ERR_MAX_BALANCE if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    in_journey
  end

  def touch_in
    raise ERR_NO_MONEY if balance < MIN_CHARGE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MIN_CHARGE)
  end

  private

  attr_reader :in_journey

  def deduct(fare)
    @balance -= fare
  end
end
