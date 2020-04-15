require_relative './module_instance_counter.rb'
require_relative './module_validation.rb'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains
  validate :name, :presence

  @@stations = []

  def self.all
    puts @@stations
  end

  def initialize(name)
    @name = name
    validate!
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

  def trains_to_block
    @trains.each { |train| yield(train)}
  end
end