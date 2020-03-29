require_relative './module_company.rb'

class Wagon
  include Company
  
  def initialize
    @train = nil
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

  protected

  def attached?
    @train != nil
  end
end