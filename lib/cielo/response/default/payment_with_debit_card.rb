module KCielo
  module Response

    class PaymentWithDebitCard < KCielo::Response::Default::Payment
      attr_accessor :tid, :authentication_url, :debit_card,
                    :links, :payment_id, :reason_code, :reason_message,
                    :return_url, :provider_return_code, :provider_return_message, :return_code

      def initialize(hash)
        super(hash)
        @authentication_url = hash['AuthenticationUrl']
        @debit_card = KCielo::Response::Default::DebitCard.new(hash['DebitCard'])
        @links = KCielo::Response::Default::Link.build_array(hash['Links'])
        @payment_id = hash['PaymentId']
        @reason_code = hash['ReasonCode']
        @reason_message = hash['ReasonMessage']
        @return_url = hash['ReturnUrl']
        @provider_return_code = hash['ProviderReturnCode']
        @provider_return_message = hash['ProviderReturnMessage']
        @tid = hash['Tid']
        @return_code = hash['ReturnCode']
      end
    end
  end
end
