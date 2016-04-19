class Oystercard
	MAXIMUM_BALANCE = 90
	
	attr_reader :balance


  def initialize
    @balance = 0
    @status = false 
  end

  def top_up(money) 
  	raise "maximum balance of #{MAXIMUM_BALANCE} exceeded" if money + balance > MAXIMUM_BALANCE
		@balance += (money)
  end	

  def deduct(money)
  	@balance -= money
  end	

  def in_journey?
  	status
  end	

  def touch_in
  	@status = true
  end
  	
  def touch_out
  	@status = false
  end	

  private
  attr_reader :status
end