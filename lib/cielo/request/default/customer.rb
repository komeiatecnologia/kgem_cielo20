module KCielo
  module Request
    module Default
      class Customer
        include KCielo::Helpers
        extend KCielo::HelpersClass

        REGEX_EMAIL = /\A([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})\z/

        cannot_be_nil :name

        attr_reader :name, :identity, :identity_type, :email, :birthdate,
                    :address, :delivery_address

        def initialize
          @name = nil
          @identity = nil #CPF ou RG sem pontos e traços
          @identity_type = nil #CPF ou CNPJ
          @email = nil
          @birthdate = nil
          @address = KCielo::Request::Default::Address.new
          @delivery_address = KCielo::Request::Default::Address.new
        end

        def name=(name)
          @name = name if valid_name?(name)
        end

        def identity=(identity)
          @identity = identity if valid_identity?(identity)
        end

        def identity_type=(type)
          @identity_type = type if valid_identity_type?(type)
        end

        def email=(email)
          @email = email if valid_email?(email)
        end

        def birthdate=(birthdate)
          @birthdate = birthdate if valid_birthdate?(birthdate)
        end

        def to_cielo_hash
          {
            "Name" => @name,
            'Identity' => @identity,
            'IdentityType' => @identity_type,
            'Email' => @email,
            'Birthdate' => @birthdate,
            'Address' => @address.to_cielo_hash,
            'DeliveryAddress' => @delivery_address.to_cielo_hash
          }
        end

        private
        def valid_name?(name)
          valid_class_type_?(:name, name, String) && present_?(name, "name")
        end

        def valid_identity?(identity)
          valid_class_type_?(:identity, identity, String)
          present_?(identity, "identity")
          valid_identification_format?(identity)
        end

        def valid_identity_type?(identity_type)
          valid_class_type_?(:identity_type, identity_type, String)
          valid_string_size_?(identity_type, :identity_type, 25)
        end

        def valid_email_format_?(email)
          raise ArgumentError, "Invalid e-mail format" if REGEX_EMAIL !~ email
          true
        end

        def valid_email?(email)
          valid_class_type_?(:email, email, String)
          valid_string_size_?(email, :email, 255)
          valid_email_format_?(email)
        end

        def valid_birthdate?(birthdate)
          valid_class_type_?(:birthdate, birthdate, String)
          valid_string_date_format_?(birthdate)
        end
      end
    end
  end
end
