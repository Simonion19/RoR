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
    
    enter = gets.chomp.to_i

    case enter
      when 1
        add_object_menu
      when 2
        edit_object_menu
      when 3
        show_data
        menu
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
        new_train = create_train
        @trains << new_train
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
        puts 'Такой команды не существует!'
        add_object_menu
    end  
  end

  def create_station
    puts 'Введите название станции'
    enter = gets.chomp.to_s
    Station.new(enter)
  rescue StandardError => e
    puts e.message
    create_station
  end

  def create_train
    puts 'Введите номер поезда'
    number = gets.chomp.to_s

    puts 'Введите 1 для выбора грузового поезда'
    puts 'Введите 2 для выбора пассажирского поезда'
    enter = gets.chomp.to_i

    begin
      enter == 1 ? (new_train = CargoTrain.new(number)) : (new_train = PassengerTrain.new(number))
    rescue StandardError => e
      puts e.message
      create_train
    end

    puts new_train
    return new_train
  end

  def create_wagon
    puts 'Введите 1 для выбора грузового вагона'
    puts 'Введите 2 для выбора пассажирского вагона'
    enter = gets.chomp.to_i

    enter == 1 ? (return CargoWagon.new) : (return PassengerWagon.new)
  end

  def create_route
    menu if !show_stations
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
    menu if !show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    menu if !show_stations
    puts 'Введите номер станции'
    station_index = gets.chomp.to_i - 1

    @routes[route_index].add_station(@stations[station_index])
  end

  def remove_station_from_route
    menu if !show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    menu if !show_stations
    puts 'Введите номер станции'
    station_index = gets.chomp.to_i - 1

    route = @routes[route_index]
    last_station = route.stations.last

    if station_index == 0 || station_index == route.stations.index(last_station)
      puts 'Нельзя удалить стартовую или конечную точку маршрута!'
    else
      @routes[route_index].remove_station(@stations[station_index])
    end
  end

  def set_route
    menu if !show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    
    menu if !show_routes
    puts 'Введите номер маршрута'
    route_index = gets.chomp.to_i - 1
    
    @trains[train_index].route=(@routes[route_index])
  end

  def add_wagon_to_train
    menu if !show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1

    menu if !show_wagons
    puts 'Введите номер вагона'
    wagon_index = gets.chomp.to_i - 1

    @trains[train_index].add_wagon(@wagons[wagon_index])
  end

  def remove_wagon_from_train
    menu if !show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    train = @trains[train_index]

    menu if !show_wagons
    puts 'Введите номер вагона'
    wagon_index = gets.chomp.to_i - 1
    wagon = @wagons[wagon_index]

    train.remove_wagon(wagon)
  end 

  def move_train_forward
    menu if !show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    train = @trains[train_index]

    begin
      if train.route
        train.move_forward
      else
        raise 'Поезду не задан маршрут'
      end
    rescue StandardError => e
      puts e.message
    end
  end

  def move_train_backward
    menu if !show_trains
    puts 'Введите номер поезда'
    train_index = gets.chomp.to_i - 1
    train = @trains[train_index]

    begin
      if train.route
        train.move_backward
      else
        raise 'Поезду не задан маршрут'
      end
    rescue StandardError => e
      puts e.message
    end
  end

  def show_data
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name},\n #{station.trains}"}
  end

  def show_stations
    raise 'Нет ни одного поезда' if @stations.length == 0
    @stations.each_with_index { |station, index| puts "#{index + 1}: #{station.name}" }
    true
  rescue StandardError => e
    puts e.message
    false
  end

  def show_routes
    raise 'Нет ни одного маршрута' if @routes.length == 0
    @routes.each_with_index { |route, index| puts "#{index + 1}: #{route}, #{route.stations}" }
    true
  rescue StandardError => e
    puts e.message
    false
  end

  def show_trains
    raise 'Нет ни одного поезда' if @trains.length == 0
    @trains.each_with_index { |train, index| puts "#{index + 1}: #{train}" }
    true
  rescue StandardError => e
    puts e.message
    false
  end

  def show_wagons
    raise 'Нет ни одного вагона' if @wagons.length == 0
    @wagons.each_with_index { |wagon, index| puts "#{index + 1}: #{wagon}" }
    true
  rescue StandardError => e
    puts e.message
    false
  end
end

rails = RailRoad.new
rails.menu