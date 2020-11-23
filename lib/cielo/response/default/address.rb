module KCielo
  module Response
    module Default
      class Address
        attr_reader :street, :number, :complement, :zip_code, :city, :state,
                    :country, :district

        def initialize(hash)
          @street = hash['Street']
          @number = hash['Number']
          @complement = hash['Complement']
          @zip_code = hash['ZipCode']
          @city = hash['City']
          @state = hash['State']
          @country = hash['Country']
          @district = hash['District']
        end
      end
    end
  end
end
