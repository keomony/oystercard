require_relative 'journey.rb'
require_relative 'station.rb'

class JourneyLog

  attr_reader :current_journey, :journeys

  def initialize(journey_klass)
    @journey_klass = journey_klass
    @journeys = []
  end

  def start(station)
      @current_journey = @journey_klass.new(station)
      @journeys << @current_journey
  end

  def finish(station)
    @current_journey.end(station)
    @journeys << current_journey
    @current_journey = nil
  end

  # def current_journey
  #   @current_journey || journey_klass.new
  # end

end
