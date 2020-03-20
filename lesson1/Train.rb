class Train
  attr_reader :amount, :number, :type, :speed

  def initialize(number, type, amount)
    @number = number
    @type = type
    @amount = amount
    @speed = 0
    @route = nil
    @currentStation = nil
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed != 0 ? @speed -= value : 0 
  end

  def add_train_car
    @speed == 0 ? @amount += 1 : (puts 'train is moving!')
  end

  def remove_train_car
    if @speed == 0
      @amount != 0 ? @amount -= 1 : 0
    else
      puts 'train is moving!'
    end
  end

  def route=(route)
    @route = route
    @route.stations.first.add_train(self)
    @currentStation = 0
  end

  def move_forward
    if @currentStation < @route.stations.length - 1
      @route.stations[@currentStation].remove_train(self)
      @currentStation += 1
      @route.stations[@currentStation].add_train(self)
    else
      puts 'its end position'
    end
  end

  def move_backward
    if @currentStation > 0
      @route.stations[@currentStation].remove_train(self)
      @currentStation -= 1
      @route.stations[@currentStation].add_train(self)
    else
      puts 'its start position'
    end
  end

  def show_nearby_stations
    if @currentStation > 0 && @currentStation < @route.stations.length - 1
      [@route.stations[@currentStation - 1], @route.stations[@currentStation], @route.stations[@currentStation + 1]]
    elsif @currentStation == 0
      [@route.stations[@currentStation], @route.stations[@currentStation + 1]]
    elsif @currentStation == @route.stations.length - 1
      [@route.stations[@currentStation - 1], @route.stations[@currentStation]]
    end
  end
end