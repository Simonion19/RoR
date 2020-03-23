require_relative './train'

class PassengerTrain < Train
  def initialize(number, wagons = [])
    super(number, wagons)
    @type = 'passenger'
  end

  def add_wagon(wagon)
    super(wagon) if wagon_passenger?(wagon)
  end

  private

  def wagon_passenger?(wagon)
    wagon.type == 'passenger'
  end
end