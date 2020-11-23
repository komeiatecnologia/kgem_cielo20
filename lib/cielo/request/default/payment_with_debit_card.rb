module KCielo
  module Request
    module Default
      class PaymentWithDebitCard < KCielo::Request::Default::Payment

        attr_accessor :debit_card
        attr_reader :return_url

        def initialize
          @debit_card = KCielo::Request::Default::DebitCard.new
          @return_url = nil
          send(:type=, :debit_card)
        end

        def return_url=(url)
          @return_url = url if valid_url?(url)
        end

        def provider=(provider)
          @provider = provider if valid_provider?(provider)
        end

        def to_cielo_hash
          h = super
          h['DebitCard'] = @debit_card.to_cielo_hash
          h['Provider'] =  KCielo.debit_card_providers[@provider]
          h['ReturnUrl'] = @return_url
          h
        end

        def valid_?
          super
          @debit_card.valid_?
        end

        private
        def valid_url?(url)
          valid_class_type_?(:return_url, url, String) && valid_url_?(url)
        end

        def valid_provider?(provider)
          valid_class_type_?(:provider, provider, Symbol)
          parameter_exists_?(provider, KCielo.debit_card_providers)
        end
      end
    end
  end
end
