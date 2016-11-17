class Journey

PENALTY_FARE = 6
MINIMUM_FARE = 1

  attr_reader :entry_station, :exit_station, :log

  def initialize(station = nil)
    @log = []
    @entry_station = station
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
    return PENALTY_FARE if incomplete?
    MINIMUM_FARE
  end

  private

  def incomplete?
    entry_station == nil || exit_station == nil
  end



end
