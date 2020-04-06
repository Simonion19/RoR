require_relative './wagon'

class PassengerWagon < Wagon
  attr_reader :type

  NUMBER_OF_SEATS = 54

  def initialize(seats = NUMBER_OF_SEATS)
    @type = 'passenger'
    @all_seats = seats
    @seats = seats
  end

  def seat 
    @seats -= 1 if @seats > 0
  end

  def free_seats
    @seats
  end

  def occupied_seats
    @all_seats - @seats
  end
end