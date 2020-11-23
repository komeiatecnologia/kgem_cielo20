module KCielo
  module Request
    module Default
      class Address
        include KCielo::Helpers
        extend KCielo::HelpersClass

        UF = /\A(AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO)\z/
        INVALID_STATE = "Invalid state, expected [AC|AL|AP|AM|BA|CE|DF|ES|GO|MA|MT|MS|MG|PA|PB|PR|PE|PI|RJ|RN|RS|RO|RR|SC|SP|SE|TO]"

        can_be_nil :street, :number, :complement, :zip_code, :city, :state,
                   :country, :district

        attr_reader :street, :number, :complement, :zip_code, :city, :state,
                    :country, :district

        def initialize
          @street = nil
          @number = nil
          @complement = nil
          @zip_code = nil
          @city = nil
          @state = nil
          @country = "BRA"
          @district = nil
        end

        def street=(street)
          @street = street if valid_street?(street)
        end

        def number=(number)
          @number = number if valid_number?(number)
        end

        def complement=(complement)
          @complement = complement if valid_complement?(complement)
        end

        def zip_code=(zip_code)
          @zip_code = zip_code if valid_zip_code?(zip_code)
        end

        def city=(city)
          @city = city if valid_city?(city)
        end

        def state=(state)
          @state = state if valid_state?(state)
        end

        def country=(country)
          @country = country if valid_country?(country)
        end

        def district=(district)
          @district = district if valid_district?(district)
        end

        def to_cielo_hash
          {
            "Street" => @street,
            "Number" => @number,
            "Complement" => @complement,
            "ZipCode" => @zip_code,
            "City" => @city,
            "State" => @state,
            "Country" => @country,
            "District" => @district
          }
        end

        private
        def valid_street?(street)
          valid_class_type_?(:street, street, String)
          valid_string_size_?(street, :street, 70)
        end

        def valid_number?(number)
          valid_class_type_?(:number, number, String)
          valid_string_size_?(number, :number, 10)
        end

        def valid_complement?(complement)
          valid_class_type_?(:complement, complement, String)
          valid_string_size_?(complement, :complement, 20)
        end

        def valid_zip_code?(zip_code)
          valid_class_type_?(:zip_code, zip_code, String)
          valid_string_size_?(zip_code, :zip_code, 9)
        end

        def valid_city?(city)
          valid_class_type_?(:city, city, String)
          valid_string_size_?(city, :city, 50)
        end

        def valid_uf?(state)
          raise(ArgumentError, INVALID_STATE) if UF !~ state
          true
        end

        def valid_state?(state)
          valid_class_type_?(:state, state, String)
          valid_uf?(state)
        end

        def valid_country?(country)
          valid_class_type_?(:country, country, String)
          valid_string_size_?(country, :country, 35)
        end

        def valid_district?(district)
          valid_class_type_?(:district, district, String)
          valid_string_size_?(district, :district, 27)
        end
      end
    end
  end
end
