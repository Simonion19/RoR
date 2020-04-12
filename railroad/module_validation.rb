module Validation
  def validate(name, type, par = nil)
    var_name = "@#{name}".to_sym
    valid_types = "@types".to_sym
    
    if !instance_variable_get(valid_types)
      instance_variable_set(valid_types, [type])
    else
      types = instance_variable_get(valid_types)
      types.push(type)
      instance_variable_set(valid_types, types)      
    end

    types = instance_variable_get(valid_types)

    define_method('validate!') do
      var = instance_variable_get(var_name)

      for item in types do
        case item.to_s
          when 'presence'
            raise 'Не заполнено!' if var.nil? || var == ''
          when 'format'
            puts 'format'
            raise 'Неверный формат!' if var !~ par
          when 'type'
            puts var.class.to_s, par
            raise 'Типы не совпадают!' if var.class.to_s != par
        end
      end
    end

    define_method('valid?') do
      validate!
      true
    rescue
      false
    end
  end
end