class Route
  attr_reader :startStation, :middleStations, :endStation

  def initialize(startStation, endStation)
    @startStation = startStation
    @endStation = endStation
    @middleStations = []
  end

  def addStation(station)
    @middleStations << station
  end

  def removeStation(station_)
    @middleStations = @middleStations.select{|station| station != station_}
  end

  def showRouteStations
    stationsToShow = @middleStations.unshift(@startStation).push(@endStation)
    puts "Route:"
    stationsToShow.each{|station| print "#{station.name} "}
  end
end