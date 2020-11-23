module KCielo
  module Request
    module Default
      class Payment
        include KCielo::Helpers

        attr_reader :type, :amount, :provider

        def initialize
          @type = nil
          @amount = nil
          @provider = nil
        end

        def type=(type)
          type = type_to_symbol_valid(type) if type.kind_of? String
          @type = KCielo.payment_types[type] if valid_type?(type)
        end

        def amount=(amount)
          amount = standardize_amount(amount)
          @amount = amount if valid_amount?(amount)
        end

        def to_cielo_hash
          {
            "Type" => @type,
            "Amount" => @amount,
            "Provider" => @provider
          }
        end

        private
        def valid_type?(type)
          valid_class_type_?(:type, type, Symbol) && parameter_exists_?(type, KCielo.payment_types)
        end

        def valid_amount?(amount)
          greater_than_zero_?(amount)
        end

        def type_to_symbol_valid(type)
          type == "Boleto" ? :payment_slip : type_to_symbol(type)
        end

        def type_to_symbol(type)
          camelcase_to_snakecase(type).to_sym
        end
      end
    end
  end
end
