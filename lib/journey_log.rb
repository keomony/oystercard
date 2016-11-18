require_relative 'journey.rb'
require_relative 'station.rb'

class JourneyLog



  def initialize(journey_klass)
    @journey_klass = journey_klass
    @journeys = []
  end

  def journeys
    @journeys.dup
  end

  def start(station)
    @current_journey = @journey_klass.new(station)
    @journeys << @current_journey
  end

  def current_journey(station)
    @journey_klass.new(station) || @current_journey
  end

end
