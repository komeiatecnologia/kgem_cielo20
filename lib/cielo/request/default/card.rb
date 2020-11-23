module KCielo
  module Request
    module Default
      class Card
        include KCielo::Helpers

        @@EXPIRATION_DATE_REGEX = /^\d{1,2}\/\d{4}$/.freeze
        @@VALID_CARD_NUMBER_FORMAT = /^(\d{16}|\d{14}|\d{15})$/.freeze

        attr_reader :card_number, :holder, :expiration_date, :security_code, :brand

        def initialize
          @card_number = nil
          @holder = nil
          @expiration_date = nil
          @security_code = nil
          @brand = nil
        end

        def card_number=(number)
          @card_number = number if valid_card_number?(number)
        end

        def holder=(holder)
          @holder = holder if valid_holder?(holder)
        end

        def expiration_date=(month_year)
          @expiration_date = month_year if valid_expiration_date?(month_year)
        end

        def security_code=(security_code)
          @security_code = security_code if valid_security_code?(security_code)
        end

        def to_cielo_hash
          {
            "CardNumber" => @card_number,
            "Holder" => @holder,
            "ExpirationDate" => @expiration_date,
            "SecurityCode" => @security_code,
            "Brand" => @brand
          }
        end

        private
        def valid_security_code?(security_code)
          valid_class_type_?(:security_code, security_code, String) && present_?(security_code, "security_code")
        end

        def valid_expiration_date?(month_year)
          valid_class_type_?(:expiration_date, month_year, String) && present_?(month_year, "expiration_date") && valid_expiration_date_format?(month_year)
        end

        def valid_holder?(holder)
          valid_class_type_?(:holder, holder,String) && present_?(holder, 'holder')
        end

        def valid_card_number?(number)
          valid_class_type_?(:card_number, number, String) && present_?(number, "card_number") && valid_card_number_format?(number)
        end

        def valid_card_number_format?(value)
          raise ArgumentError, "Invalid card number format: #{value}, expected 11112222333344??(14, 15 or 16 digits)", "#{self.class}" if value !~ @@VALID_CARD_NUMBER_FORMAT
          true
        end

        def valid_expiration_date_format?(month_year)
          raise ArgumentError, "Invalid date format: #{month_year}, expected MM/YYYY", "#{self.class}" if month_year !~ @@EXPIRATION_DATE_REGEX
          true
        end
      end
    end
  end
end
