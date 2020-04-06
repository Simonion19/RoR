require_relative './wagon'

class CargoWagon < Wagon
  attr_reader :type
  
  VOLUME = 150

  def initialize(volume = VOLUME)
    @type = 'cargo'
    @all_volume = volume
    @volume = volume
  end

  def occupy_volume(volume) 
    @volume -= volume if @volume - volume >= 0
  end

  def free_volume
    @volume
  end

  def occupied_volume
    @all_volume - @volume
  end
end