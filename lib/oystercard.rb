class Oystercard

attr_reader :balance

MAX_BALANCE = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  private

  def limit_exceeded?(amount)
    raise "Max limit is £90" if (@balance + amount) > MAX_BALANCE
  end


end
