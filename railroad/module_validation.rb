module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :types

    def validate(name, type, par = "")
      self.types ||= []

      new_type = {
        name: name,
        type: type,
        par: par
      }

      types << new_type
    end
  end

  module InstanceMethods
    def validate!
      self.class.types.each do |item|
        var = instance_variable_get("@#{item[:name]}".to_sym)
        send("validate_#{item[:type]}", var, item[:par])
      end
    end
    
    def valid?
      validate!
      true
    rescue
      false
    end

    def validate_presence(var, par)
      raise 'Не заполнено!' if var.nil? || var == ''
    end

    def validate_format(var, format)
      raise 'Неверный формат!' if var !~ format
    end

    def validate_type(var, type)
      raise 'Типы не совпадают!' if var.class.to_s != type
    end

    def validate_length(var, length)
      raise "Должно быть от #{length[:min]} до #{length[:max]} символов!" if var.to_s.length > length[:max] || var.to_s.length < length[:min]
    end

    def validate_equality(first, last)
      last_var = instance_variable_get("@#{last}")
      raise "Одинаковые первая и последняя станция" if first == last_var
    end
  end
end