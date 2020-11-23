module KCielo
  module Response
    module Default
      class Customer
        attr_reader :name, :identity, :identity_type, :email, :address,
                    :delivery_address

        def initialize(hash)
          @name = hash['Name']
          @identity = hash['Identity']
          @identity_type = hash['IdentityType']
          @email = hash['Email']
          @address = KCielo::Response::Default::Address.new(hash['Address']) if hash['Address']
          @delivery_address = KCielo::Response::Default::Address.new(hash['DeliveryAddress']) if hash['DeliveryAddress']
        end
      end
    end
  end
end
