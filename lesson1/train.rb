class Train
  attr_reader :amount, :number, :type, :speed

  def initialize(number, type, amount)
    @number = number
    @type = type
    @amount = amount
    @speed = 0
    @route = nil
    @current_station = nil
  end

  def increase_speed(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed - value < 0 ? @speed = 0 : @speed -= value 
  end

  def add_train_car
    @amount += 1
  end

  def remove_train_car
    if @speed == 0
      @amount == 0 ? @amount = 0 : @amount -= 1
    end
  end

  def route=(route)
    @route = route
    @route.stations.first.add_train(self)
    @current_station = 0
  end

  def move_forward
    if @current_station < @route.stations.length - 1
      @route.stations[@current_station].remove_train(self)
      @current_station += 1
      @route.stations[@current_station].add_train(self)
    end
  end

  def move_backward
    if @current_station > 0
      @route.stations[@current_station].remove_train(self)
      @current_station -= 1
      @route.stations[@current_station].add_train(self)
    end
  end

  def get_prev_station
    if @current_station > 0
      @route.stations[@current_station - 1]
    end
  end

  def get_current_station
    @route.stations[@current_station]
  end

  def get_next_station
    if @current_station < @route.stations.length - 1
      @route.stations[@current_station + 1]
    end
  end
end