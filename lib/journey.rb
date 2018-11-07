require_relative 'station'

class Journey
  attr_reader :fare, :current_journey, :journey_log, :moving

  MIN_FARE = 1
  PENALTY_CHARGE = 6

  def initialize
    @moving = false
    @journey_log = []
    @current_journey = {}
  end

  def start_journey(station)
    @moving = true
    @current_journey[:entry] = station
  end

  def end_journey(station)
    @moving = false
    @current_journey[:exit] = station
    @journey_log << @current_journey
  end

  private

  def in_journey?
    !@current_journey[:entry].nil? && @current_journey[:exit].nil?
  end

end
