class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train)
    @trains << train
  end

  def remove_train(train)
    @trains.delete(train){"not found"}
  end

  def get_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end
end