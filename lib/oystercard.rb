class Oystercard

attr_reader :balance, :moving

MAX_BALANCE = 90
MIN_BALANCE = 1

  def initialize(balance = 5, moving = false)
    @balance = balance
    @moving = moving
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(credit)
    no_credit?(credit)
    @moving = true
  end

  def touch_out
    @moving = false
  end

  private

  def limit_exceeded?(amount)
    raise "Max limit is £90" if (@balance + amount) > MAX_BALANCE
  end

  def no_credit?(credit)
    raise "Not enough credit" if (@balance + credit) < MIN_BALANCE
  end


end
