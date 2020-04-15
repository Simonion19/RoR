require_relative './train'
require_relative './module_validation.rb'


class CargoTrain < Train
  include Validation

  NUMBER_FORMAT = /[А-яA-z0-9]{3}-?[А-яA-z0-9]{2}/
  validate :number, :length , {min: 5, max: 6}
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, wagons = [])
    super
    @type = 'cargo'
  end

  def add_wagon(wagon)
    super(wagon) if wagon_cargo?(wagon)
  end

  private

  def wagon_cargo?(wagon)
    wagon.type == @type
  end
end