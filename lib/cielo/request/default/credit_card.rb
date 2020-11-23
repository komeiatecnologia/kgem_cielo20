module KCielo
  module Request
    module Default
      class CreditCard < Card

        def brand=(brand)
          @brand = KCielo.credit_card_brands[brand] if valid_brand?(brand)
        end

        private
        def valid_brand?(brand)
          valid_class_type_?(:brand, brand, Symbol) && parameter_exists_?(brand, KCielo.credit_card_brands)
        end

      end
    end
  end
end
