class Oystercard

attr_reader :balance, :moving, :entry_station, :exit_station, :history

MAX_BALANCE = 90
MIN_BALANCE = 1
MIN_FARE = 1

  def initialize(balance = 0, moving = false)
    @balance = balance
    @moving = moving
    @history = {0 => []}
  end

  def top_up(amount)
    limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    no_credit?
    @moving = true
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @moving = false
    @exit_station = exit_station
    store_journey
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

  def store_journey
    history[history.keys.last.next] = [entry_station]
    history.values.last << exit_station
  end


end
