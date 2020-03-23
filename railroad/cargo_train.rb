require_relative './train'

class CargoTrain < Train
  def initialize(number, wagons = [])
    super(number, wagons)
    @type = 'cargo'
  end

  def add_wagon(wagon)
    super(wagon) if wagon_cargo?(wagon)
  end

  private

  def wagon_cargo?(wagon)
    wagon.type == 'cargo'
  end
end