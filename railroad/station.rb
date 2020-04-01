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

  def valid?
    validate!
    true
  rescue StandardError => e
    puts e.message
    false
  end

  protected

  def validate!
    raise "Name can't be nil" if @name.nil?
    raise "Name should be at least 5 symbols" if @name.length < 5
  end
end