require_relative 'journey.rb'
require_relative 'station.rb'

class Oystercard

  attr_reader :balance, :journey

    MAXIMUM_BALANCE = 90
    MINIMUM_BALANCE = 1

    def initialize
      @balance = 0
    end

    def top_up(amount)
      raise "Cannot top up: balance capacity of #{MAXIMUM_BALANCE} has been exceeded" if balance + amount > MAXIMUM_BALANCE
      @balance += amount
    end

     def touch_in(station)
       raise "Cannot touch in: not enough funds" if balance < MINIMUM_BALANCE
       Journey.new(station)
     end

     def touch_out(exit_station)
       @balance -= MINIMUM_BALANCE
     end

     private

     def deduct(amount)
       @balance -= amount
     end

  end
