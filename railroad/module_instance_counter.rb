module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances
    end

    def add_instance
      @instances ? @instances += 1 : @instances = 1
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.add_instance
    end
  end
end