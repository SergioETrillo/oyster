class Oystercard

  MAX_BALANCE = 90
  ERR_MAX_BALANCE = "max_balance can't be >£90".freeze
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise ERR_MAX_BALANCE if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

end
