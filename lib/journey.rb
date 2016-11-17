class Journey

  attr_reader :entry_station, :exit_station, :log

  def initialize
    @log = []
  end

  def start(station)
    @entry_station = station
  end

  def end(station)
    @exit_station = station
    log << store_journey
    @entry_station = nil
  end

  def store_journey
    {entry_station => exit_station}
  end

  def in_journey?
    !!entry_station
  end




end
