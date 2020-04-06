require_relative './wagon'

class PassengerWagon < Wagon
  attr_reader :type

  NUMBER_OF_SEATS = 50

  def initialize(seats = NUMBER_OF_SEATS)
    @type = 'passenger'
    super(seats)
  end
end