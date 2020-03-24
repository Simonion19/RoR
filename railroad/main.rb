require_relative './route'
require_relative './station'
require_relative './passenger_train'
require_relative './cargo_train'
require_relative './passenger_wagon'
require_relative './cargo_wagon'

class RailRoad
  attr_reader :trains

  def initialize
    @stations = []  
    @trains = []
    @wagons = []
    @routes = []
  end

  def menu
    puts 'Введите 1 для создания станции, маршрута, поезда или вагона'
    puts 'Введите 2 для изменения созданных объектов'
    puts 'Введите 3 для просмотра данных о созданных объектах'
    puts 'Введите 0 для остановки программы'
    
    enter = gets.chomp.to_i

    case enter
      when 1
        add_object_menu
      when 2
        edit_object_menu
      when 3
        show_data
        menu
      when 0
        return 0
      else
        puts 'Такой команды не существует!'
        menu
    end
  end

  private

  def add_object_menu
    puts 'Введите 1 для создания станции'
    puts 'Введите 2 для создания поезда'
    puts 'Введите 3 для создания вагона'
    puts 'Введите 4 для создания маршрута'
    puts 'Введите 0 для возвращения в меню'

    enter = gets.chomp.to_i
    case enter
      when 1
        @stations << create_station
        add_object_menu
      when 2
        @trains << create_train
        add_object_menu
      when 3
        @wagons << create_wagon
        add_object_menu
      when 4
        @routes << create_route
        add_object_menu
      when 0
        menu
      else
        puts 'Введите 1 для создания станции'
        add_object_menu
    end  
  end

  def create_station
    puts 'Введите название станции'
    enter = gets.chomp.to_s
    Station.new(enter)
  end

  def create_train
    puts 'Введите номер поезда'
    number = gets.chomp.to_s

    puts 'Введите 1 для выбора грузового поезда'
    puts 'Введите 2 для выбора пассажирского поезда'
    enter = gets.chomp.to_i

    enter == 1 ? (return CargoTrain.new(number)) : (return PassengerTrain.new(number))
  end

  def create_wagon
    puts 'Введите 1 для выбора грузового вагона'
    puts 'Введите 2 для выбора пассажирского вагона'
    enter = gets.chomp.to_i

    enter == 1 ? (return CargoWagon.new) : (return PassengerWagon.new)
  end

  def create_route
    show_stations
    puts 'Введите номер станции отправления'
    start_index = gets.chomp.to_i - 1
    puts 'Введите номер станции прибытия'
    end_index = gets.chomp.to_i - 1

    Route.new(@stations[start_index], @stations[end_index])
  end

  def edit_object_menu
    puts 'Введите 1 для добавления станции в маршрут'
    puts 'Введите 2 для удаления станции из маршрута'
    puts 'Введите 3 для установки маршрута поезду'
    puts 'Введите 4 для добавления вагона к поезду'
    puts 'Введите 5 для удаления вагона из поезда'
    puts 'Введите 6 для перемещения поезда вперед'
    puts 'Введите 7 для перемещения поезда назад'
    puts 'Введите 0 для возвращения в меню'
    
    enter = gets.chomp.to_i

    case enter
      when 1
        add_station_to_route
        edit_object_menu
      when 2
        remove_station_from_route
        edit_object_menu
      when 3
        set_route
        edit_object_menu
      when 4
        add_wagon_to_train
        edit_object_menu
      when 5
        remove_wagon_from_train
        edit_object_menu
      when 6
        move_train_forward
        edit_object_menu
      when 7
        move_train_backward
        edit_object_menu
      when 0
        menu
      else
        puts 'Такой команды не существует!'
        edit_object_menu        
    end
  end

  def add_station_to_route
    show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    show_stations
    puts 'Введите номер станции'
    station_index = gets.chomp.to_i - 1

    @routes[route_index].add_station(@stations[station_index])
  end

  def remove_station_from_route
    show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    show_stations
    puts 'Введите номер станции'
    station_index = gets.chomp.to_i - 1

    route = @routes[route_index]
    last_station = route.last

    if station_index == 0 || station_index == route.index(last_station)
      puts 'Нельзя удалить стартовую или конечную точку маршрута!'
    else
      @routes[route_index].remove_station(@stations[station_index])
    end
  end

  def set_route
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    
    show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    @trains[train_index].route=(@routes[route_index])
  end

  def add_wagon_to_train
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1

    show_wagons
    puts 'Введите номер вагона'
    wagon_index = gets.chomp.to_i - 1

    @trains[train_index].add_wagon(@wagons[wagon_index])
  end

  def remove_wagon_from_train
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1

    show_wagons
    puts 'Введите номер вагона'
    wagon_index = gets.chomp.to_i - 1

    @trains[train_index].remove_wagon(@wagons[wagon_index])
  end 

  def move_train_forward
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    
    train = @trains[train_index]
    train.move_forward
  end

  def move_train_backward
    show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    
    train = @trains[train_index]
    train.move_backward
  end

  def show_data
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name},\n #{station.trains}"}
  end

  def show_stations
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
  end

  def show_routes
    @routes.each_with_index { |route, index| puts "#{index + 1}: #{route}, #{route.stations}" }
  end

  def show_trains
    @trains.each_with_index { |train, index| puts "#{index + 1}: #{train}" }
  end

  def show_wagons
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}: #{wagon}" }
  end
end

rails = RailRoad.new
rails.menu
puts rails.trains
puts rails.trains[0].prev_station
puts rails.trains[0].current_station
puts rails.trains[0].next_station