require_relative 'station'
require_relative 'journey_log'

class Oystercard

attr_reader :balance

MAX_BALANCE = 90
MIN_BALANCE = 1


  def initialize(balance = 0, journey_log = JourneyLog.new)
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    no_credit?
    penalty_apply?
    @journey_log.track_entry(station)
  end

  def touch_out(station)
    @journey_log.track_exit(station)
    charge_fare
    @journey_log.current_journey = {}
  end

  def charge_fare
    @balance -= @journey_log.calculate_fare
  end

  def penalty_apply?
    @balance -= @journey_log.penalty
  end

  def history
    @journey_log.journeys
  end

  private

  def limit_exceeded?(amount)
    raise "Max limit is £90" if (@balance + amount) > MAX_BALANCE
  end

  def no_credit?
    raise "Not enough credit" if @balance < MIN_BALANCE
  end

end
