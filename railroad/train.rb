class Train
  attr_reader :wagons, :number, :type, :speed, :route

  def initialize(number, wagons = [])
    @number = number
    @wagons = wagons
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

  def add_wagon(wagon)
    @wagons << wagon
    wagon.attach(self)
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)
    wagon.detach
  end

  def route=(route)
    @route = route
    first_station.add_train(self)
    @current_station = 0
  end
  
  def current_station
    @route.stations[@current_station]
  end

  def prev_station
    if !first_station?
      @route.stations[@current_station - 1]
    end
  end
  
  def next_station
    if !last_station?
      @route.stations[@current_station + 1]
    end
  end

  def move_forward
    if next_station
      current_station.remove_train(self)
      @current_station += 1
      current_station.add_train(self)
    else
      puts 'Это конечная станция'
    end
  end

  def move_backward
    if prev_station
      current_station.remove_train(self)
      @current_station -= 1
      current_station.add_train(self)
    else
      puts 'Это первая станция маршрута'
    end
  end

  protected
  # Вспомогательные методы, используются только в самом классе
  def first_station
    @route.stations.first
  end

  def last_station
    @route.stations.last
  end

  def first_station?
    current_station == first_station
  end

  def last_station?
    current_station == last_station
  end
end