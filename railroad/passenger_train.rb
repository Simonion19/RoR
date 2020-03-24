require_relative './train'

class PassengerTrain < Train
  def initialize(number, wagons = [])
    super(number, wagons)
    @type = 'passenger'
  end

  def add_wagon(wagon)
    wagon_passenger?(wagon) ? super(wagon) : (puts 'Вагон неподходящего типа!')
  end

  private

  def wagon_passenger?(wagon)
    wagon.type == @type
  end
end