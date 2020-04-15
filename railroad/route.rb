require_relative './module_instance_counter.rb'
require_relative './module_validation.rb'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations
  validate :first_station, :presence
  validate :last_station, :presence
  validate :first_station, :type, 'Station'
  validate :last_station, :type, 'Station'
  validate :first_station, :equality, :last_station

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @first_station = start_station
    @last_station = end_station
    validate!
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    if station != @stations.first && station != @stations.last
      @stations.delete(station){"not found"}
    end
  end

  def show_route_stations
    puts "Route:"
    @stations.each { |station| print "#{station.name} " }
  end
end