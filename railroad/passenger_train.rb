require_relative './train'
require_relative './module_validation.rb'


class PassengerTrain < Train
  include Validation

  NUMBER_FORMAT = /[А-яA-z0-9]{3}-?[А-яA-z0-9]{2}/
  validate :number, :length , {min: 5, max: 6}
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, wagons = [])
    super
    @type = 'passenger'
  end

  def add_wagon(wagon)
    super(wagon) if wagon_passenger?(wagon)
  end

  private

  def wagon_passenger?(wagon)
    wagon.type == @type
  end
end