require_relative 'station'
require_relative 'journey'

class Oystercard

attr_reader :balance

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = 1
PENALTY_CHARGE = 6

  def initialize(balance = 0, journey = Journey.new)
    @balance = balance
    @journey = journey
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    no_credit?
    @journey.start_journey(station)
  end

  def touch_out(station)
    @journey.end_journey(station)
    #charge_fare(fare)
  end

  def status
    @journey.in_journey?
  end

  def history
    @journey.journey_log
  end

  def charge_fare(fare)
    @balance -= MIN_FARE
    @balance -= PENALTY_CHARGE
  end

  private

  def limit_exceeded?(amount)
    raise "Max limit is £90" if (@balance + amount) > MAX_BALANCE
  end

  def no_credit?
    raise "Not enough credit" if @balance < MIN_BALANCE
  end

end
