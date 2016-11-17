class Journey

PENALTY_FARE = 6
MINIMUM_FARE = 1

  attr_reader :entry_station, :exit_station, :log, :fare

  def initialize(station = nil)
    @log = []
    @entry_station = station
    @fare = PENALTY_FARE
  end

  def end(station)
    @exit_station = station
    log << store_journey
  end

  def store_journey
    {entry_station => exit_station}
  end

  def in_journey?
    entry_station && !exit_station
  end

  def calculate_fare
    @fare = MINIMUM_FARE if complete?
    @fare
  end

  private

  def complete?
    entry_station && exit_station
  end



end
