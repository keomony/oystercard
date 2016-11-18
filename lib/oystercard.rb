require_relative 'journey'

class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  attr_accessor :journey_log, :balance, :entry_station, :current_journey

  def initialize
    @balance = 0
    @journey_log = []
  end

  def top_up(value)
    raise "Cannot top up: £#{MAXIMUM_LIMIT} limit would be exceeded" if max_exceeded?(value)
    self.balance += value
  end

  def touch_in(station)
    raise "Insufficient funds. You need to top up." if insufficient_funds?
    deduct_fare if !current_journey.nil?
    start_journey(station)
  end

  def touch_out(station)
    end_journey(station)
    deduct_fare
    self.current_journey = nil
  end

  private

  def start_journey(station)
    self.current_journey = Journey.new
    current_journey.enter_at(station)
    self.entry_station = station
  end

  def end_journey(station)
    self.current_journey.exit_at(station)
    self.journey_log << {entry_station => station}
  end

  def insufficient_funds?
    balance < MINIMUM_FARE
  end

  def deduct_fare
      self.balance -= current_journey.calculate_fare
  end

  def max_exceeded?(value)
    self.balance + value > MAXIMUM_LIMIT
  end

end
