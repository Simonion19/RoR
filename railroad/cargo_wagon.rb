require_relative './wagon'

class CargoWagon < Wagon
  attr_reader :type

  NUMBER_OF_VOLUME = 150

  def initialize(volume = NUMBER_OF_VOLUME)
    super(volume, 'cargo')
  end
end