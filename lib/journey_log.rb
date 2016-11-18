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

  def finish(station)
      if @current_journey
        @current_journey.end(station)
      else
        @current_journey = @journey_klass.new
        @journeys << @current_journey
        @current_journey.end(station)
      end

      @current_journey = nil
  end

  private

  def current_journey
    @current_journey || @journey_klass.new
  end

end
