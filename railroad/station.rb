require_relative './module_instance_counter.rb'
require_relative './module_valid?.rb'

class Station
  include InstanceCounter
  include Valid
  attr_reader :name, :trains

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

  protected

  def validate!
    raise "Name can't be nil" if @name.nil?
  end
end