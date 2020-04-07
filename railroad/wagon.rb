require_relative './module_company.rb'

class Wagon
  include Company
  
  def initialize(value, type)
    @train = nil
    @type = type
    @all_value = value
    @free_value = value
  end

  def train
    @train if attached?
  end

  def attach(train)
    @train = train if !attached?
  end

  def detach
    @train = nil
  end

  def occupy(value)
    @free_value -= value if @free_value - value >= 0
  end

  def occupied
    @all_value - @free_value
  end

  protected

  def attached?
    @train != nil
  end
end