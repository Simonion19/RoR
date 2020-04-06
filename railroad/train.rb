require_relative './module_company.rb'
require_relative './module_instance_counter.rb'
require_relative './module_valid?.rb'

class Train
  include Company
  include InstanceCounter
  include Valid

  attr_reader :wagons, :number, :type, :speed, :route

  NUMBER_FORMAT = /[А-яA-z0-9]{3}-?[А-яA-z0-9]{2}/

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, wagons = [])
    @number = number.to_s
    validate!
    @wagons = wagons
    @speed = 0
    @route = nil
    @current_station = nil
    @@trains[number] = self
    register_instance
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed - value < 0 ? @speed = 0 : @speed -= value 
  end

  def add_wagon(wagon)
    @wagons << wagon
    wagon.attach(self)
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)
    wagon.detach
  end

  def route=(route)
    @route = route
    first_station.add_train(self)
    @current_station = 0
  end
  
  def current_station
    @route.stations[@current_station]
  end

  def prev_station
    if !first_station?
      @route.stations[@current_station - 1]
    end
  end
  
  def next_station
    if !last_station?
      @route.stations[@current_station + 1]
    end
  end

  def move_forward
    if next_station
      current_station.remove_train(self)
      @current_station += 1
      current_station.add_train(self)
    end
  end

  def move_backward
    if prev_station
      current_station.remove_train(self)
      @current_station -= 1
      current_station.add_train(self)
    end
  end

  def wagons_to_block
    @wagons.each_with_index { |wagon, index| yield(wagon, index) }
  end

  protected

  def validate!
    raise "Number can't be nil" if @number.nil?
    raise "Number should be at least 5 symbols" if @number.length < 5
    raise "Number length can't be more than 6 symbols" if @number.length > 6
    raise "Number has invalid format" if @number !~ NUMBER_FORMAT
  end

  def first_station
    @route.stations.first
  end

  def last_station
    @route.stations.last
  end

  def first_station?
    current_station == first_station
  end

  def last_station?
    current_station == last_station
  end
end