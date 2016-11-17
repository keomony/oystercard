require_relative 'journey'

class OysterCard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  attr_accessor :journey_log, :balance, :entry_station, :journey

  def initialize
    @balance = 0
    @journey_log = []
    @journey = nil
  end

  def top_up(value)
    raise "Cannot top up: £#{MAXIMUM_LIMIT} limit would be exceeded" if max_exceeded?(value)
    self.balance += value
  end

  def touch_in(station)
    raise "Insufficient funds. You need to top up." if insufficient_funds?
    deduct_fare if !journey.nil?
    self.journey = Journey.new
    journey.enter_at(station)
    self.entry_station = station
  end

  def touch_out(station)
    self.journey.exit_at(station)
    self.journey_log << {entry_station => station}
    deduct_fare
    self.journey = nil
  end

  private
  def insufficient_funds?
    balance < MINIMUM_FARE
  end

  def deduct_fare
      self.balance -= journey.calculate_fare
  end

  def max_exceeded?(value)
    self.balance + value > MAXIMUM_LIMIT
  end

end
