module KCielo
  module Response
    module Default
      VARIABLES_ATTRIBUTES = ['proof_of_sale', 'authorization_code',
        'received_date', 'captured_amount', 'captured_date', 'voided_amount',
        'voided_date'
      ]

      class Payment
        include KCielo::Meta
        include KCielo::Helpers

        attr_reader :type, :amount, :country, :currency, :provider, :status,
                    :extra_data_collection, :status_message

        def initialize(hash)
          @type = hash['Type']
          @amount = hash['Amount']
          @country = hash['Country']
          @currency = hash['Currency']
          @provider = hash['Provider']
          @status = hash['Status']
          @status_message = KCielo::Pagador::STATUS[@status]
          @extra_data_collection = hash['ExtraDataCollection']
          set_variables_attributes(hash)
        end

        private
        def set_variables_attributes(hash)
          VARIABLES_ATTRIBUTES.each do |att|
            create_method(att, hash) if hash.key? parse_key(att)
          end
        end

        def create_method(att, hash)
          create_get_method att, hash[parse_key(att)]
        end

        def parse_key(att)
          snakecase_to_cielocase(att)
        end
      end
    end
  end
end
