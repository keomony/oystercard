class JourneyLog

  attr_reader :current_journey

  def initialize(journey_klass)
    @journey_klass = journey_klass
    @log = []
  end

  def start(station)
    @current_journey = @journey_klass.new(station)
  end

  def finish(station)
    @current_journey.end(station)
    @log << current_journey
  end

end
