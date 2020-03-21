class Route
  attr_reader :stations

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
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