require_relative 'station'

class Journey
  attr_reader :current_journey, :journey_log, :in_journey

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

end
