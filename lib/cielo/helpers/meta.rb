module KCielo
  module Meta
    def create_get_method(name, value)
      instance_variable_set("@#{name}".to_sym, value)
      singleton = class << self; self end
      singleton.send :define_method, name.to_sym, lambda { eval("@#{name}") }
    end
  end
end
