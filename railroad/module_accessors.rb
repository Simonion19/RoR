module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_array_name = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}_history".to_sym) { instance_variable_get(history_array_name) }

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)

        if !instance_variable_get(history_array_name)
          instance_variable_set(history_array_name, [value])
        else
          history_array = instance_variable_get(history_array_name)
          history_array.push(value)
          instance_variable_set(history_array_name, history_array)
        end
      end
    end
  end

  def strong_attr_accessor(name, type)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise 'Типы не совпадают!' if value.class != type
      instance_variable_set(var_name, value)
    end
  end
end

class Test
  extend Accessors
  
  attr_accessor_with_history :a
  strong_attr_accessor :b, Integer
end