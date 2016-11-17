class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
  end

  def exit_at(station)
    @exit_station = station
  end

  def is_complete?
    true
  end

  def calculate_fare
    return MINIMUM_FARE if is_complete?
    PENALTY_FARE
  end
end
