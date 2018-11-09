require_relative 'station'

class Journey
  attr_reader :in_journey

  def initialize
    @in_journey = false
  end

  def start_journey
    @in_journey = true
  end

  def end_journey
    @in_journey = false
  end

  def in_journey?
    !@current_journey[:entry].nil? && @current_journey[:exit].nil?
  end

end
