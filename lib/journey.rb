require_relative 'station'

class Journey
  attr_reader :journey_log, :in_journey
  attr_accessor :current_journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @in_journey = false
    @journey_log = []
    @current_journey = {}
  end

  def start_journey(station)
    @in_journey = true
    @current_journey[:entry] = station
  end

  def end_journey(station)
    @in_journey = false
    @current_journey[:exit] = station
    @journey_log << @current_journey
  end

  def in_journey?
    !@current_journey[:entry].nil? && @current_journey[:exit].nil?
  end

  def penalty
    @current_journey.empty? ? 0 : PENALTY_FARE
  end

  def decide_fare
    !@current_journey[:entry].nil? ? MIN_FARE : PENALTY_FARE
  end

end
