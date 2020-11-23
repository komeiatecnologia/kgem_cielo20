module KCielo
  module HelpersClass

    def can_be_nil(*ary)
      define_class_method("CAN_BE_NIL", ary)
    end

    def cannot_be_nil(*ary)
      define_class_method("CANNOT_BE_NIL", ary)
    end

    private
    def define_class_method(name, ary = nil, &block)
      class_variable_set("@@#{name}", ary) if ary
      (class << self; self; end).instance_eval do
        define_method(name) { class_variable_get("@@#{name}") }
      end
    end
  end
end
