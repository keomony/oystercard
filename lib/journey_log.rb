require_relative 'journey.rb'
require_relative 'station.rb'

class JourneyLog

  def initialize(journey_klass)
    @journey_klass = journey_klass
  end

  def start(station)
    journey = @journey_klass.new(station)
  end

end
