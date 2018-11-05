class Oystercard

attr_reader :balance, :moving, :entry_station

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = 1

  def initialize(balance = 0, moving = false)
    @balance = balance
    @moving = moving
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    no_credit?
    @entry_station = entry_station
    @moving = true
  end

  def touch_out(entry_station)
    deduct(MIN_FARE)
    @entry_station = nil
    @moving = false
  end

  private

  def deduct(fare)
    @balance -= fare
  end

  def limit_exceeded?(amount)
    raise "Max limit is £90" if (@balance + amount) > MAX_BALANCE
  end

  def no_credit?
    raise "Not enough credit" if @balance < MIN_BALANCE
  end


end
