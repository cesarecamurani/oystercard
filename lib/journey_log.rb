require_relative 'journey'
require_relative 'station'

class JourneyLog
  attr_accessor :current_journey, :journeys

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(journey = Journey.new)
    @journey = journey
    @journeys = []
    @current_journey = {}
  end

  def track_entry(station)
    @journey.start_journey
    @current_journey[:entry] = station
  end

  def track_exit(station)
    @journey.end_journey
    @current_journey[:exit] = station
    store_journey
  end

  def store_journey
    @journeys << @current_journey
  end

  def journeys
    @journeys.clone
  end

  def penalty
    @current_journey.empty? ? 0 : PENALTY_FARE
  end

  def calculate_fare
    !@current_journey[:entry].nil? ? MIN_FARE : PENALTY_FARE
  end

end
