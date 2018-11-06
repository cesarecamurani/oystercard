require_relative 'station'

class Oystercard

attr_reader :balance, :moving, :history

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = 1

  def initialize(balance = 0, moving = false)
    @balance = balance
    @moving = moving
    @history = {}
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    no_credit?
    @moving = true
    history[:entry] = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @moving = false
    history[:exit] = station
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
