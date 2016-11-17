class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def enter_at(station)
    @entry_station = station
  end

  def exit_at(station)
    @exit_station = station
  end

  def is_complete?
    entry_station && exit_station
  end

  def is_not_complete?
    !entry_station.nil? || !exit_station.nil?
  end

  def calculate_fare
    return MINIMUM_FARE if is_complete?
    PENALTY_FARE
  end
end
