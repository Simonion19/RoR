class Route
  attr_reader :stations

  def initialize(startStation, endStation)
    @stations = [startStation, endStation]
  end

  def add_station(station)
    @stations << @stations[@stations.length - 1]
    @stations[-2] = station
  end

  def remove_station(station)
    @stations.delete(station){"not found"}
  end

  def show_route_stations
    puts "Route:"
    @stations.each{|station| print "#{station.name} "}
  end
end