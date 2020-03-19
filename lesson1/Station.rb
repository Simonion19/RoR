class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def addTrain(train)
    @trains << train
  end

  def removeTrain(trainNumber)
    @trains = @trains.select{|train| train.number != trainNumber}
  end

  def showTrainList
    puts "Trains:"
    @trains.each{|train| print "#{train.number} \n"}
  end

  def showTrainsByType(type)
    trainsToShow = @trains.select{|train| train.type == type}
    puts "Trains by type: #{type}"
    trainsToShow.each{|train| print "#{train.number} \n"}
  end
end