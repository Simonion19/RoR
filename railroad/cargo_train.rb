require_relative './train'

class CargoTrain < Train
  def initialize(number, wagons = [])
    super(number, wagons)
    @type = 'cargo'
  end

  def add_wagon(wagon)
    wagon_cargo?(wagon) ? super(wagon) : (puts 'Вагон неподходящего типа!')
  end

  private

  def wagon_cargo?(wagon)
    wagon.type == @type
  end
end