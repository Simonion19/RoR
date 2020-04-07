require_relative './wagon'

class PassengerWagon < Wagon
  attr_reader :type

  NUMBER_OF_SEATS = 50

  def initialize(seats = NUMBER_OF_SEATS)
    super(seats, 'passenger')
  end

  def occupy
    super(1)
  end
end