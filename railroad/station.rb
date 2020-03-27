require_relative './module_instance_counter.rb'

class Station
  include InstanceCounter
  attr_reader :name, :trains

  @@stations = []

  def self.all
    puts @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train){"not found"}
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end
end