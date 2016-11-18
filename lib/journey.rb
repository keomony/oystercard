class Journey
  attr_reader :entry_station, :exit_station

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def enter_at(station)
    @entry_station = station
  end

  def exit_at(station)
    @exit_station = station
  end

  def is_complete?
    return entry_station && exit_station
  end

  def calculate_fare
    return is_complete? ? MINIMUM_FARE : PENALTY_FARE
  end
end
