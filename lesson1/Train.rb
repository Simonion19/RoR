class Train
  attr_accessor :speed

  attr_reader :amount, :number, :type

  def initialize(number, type, amount)
    @number = number
    @type = type
    @amount = amount
    @speed = 0
    @route = nil
    @currentStation = nil
  end

  def stop
    self.speed = 0
  end

  def changeAmount(action)
    if @speed == 0
      if action == '+'
        @amount += 1
      elsif action == '-' && @amount != 0
        @amount -= 1
      elsif action == '-' && @amount == 0
        puts 'Error: amount of train cars is 0'
      end
    else
      puts 'train is moving!'
    end
  end

  def route=(route)
    @route = route.middleStations.unshift(route.startStation).push(route.endStation)
    @route[0].addTrain(self)
    @currentStation = 0
  end

  def changeStation(action)
    if action == '+'
      if @currentStation < @route.length - 1
        @route[@currentStation].removeTrain(self)
        @currentStation += 1
        @route[@currentStation].addTrain(self)
      else
        puts 'its done'
      end
    elsif action == '-'
      if @currentStation > 0
        @route[@currentStation].removeTrain(self)
        @currentStation -= 1
        @route[@currentStation].addTrain(self)
      else
        puts 'its start position'
      end
    end
  end

  def showNearbyStations
    if @currentStation > 0 && @currentStation < @route.length - 1
      puts "prev: #{@route[@currentStation - 1].name}"
      puts "current: #{@route[@currentStation].name}"
      puts "next: #{@route[@currentStation + 1].name}" 
    elsif @currentStation == 0
      puts "current: #{@route[@currentStation].name}" 
      puts "next: #{@route[@currentStation + 1].name}"
    elsif @currentStation == @route.length - 1
      puts "prev: #{@route[@currentStation - 1].name}" 
      puts "current: #{@route[@currentStation].name}"
    end
  end
end