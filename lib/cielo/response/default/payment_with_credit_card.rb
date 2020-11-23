module KCielo
  module Response

    class PaymentWithCreditCard < KCielo::Response::Default::Payment
      attr_accessor :tid, :authenticate, :capture,
                    :credit_card, :installments, :interest, :links, :payment_id,
                    :reason_code, :reason_message, :service_tax_amount,
                    :proof_of_sale, :authorization_code, :provider_return_code,
                    :provider_return_message, :return_code

      def initialize(hash)
        super(hash)
        @authenticate = hash['Authenticate']
        @capture = hash['Capture']
        @credit_card = KCielo::Response::Default::CreditCard.new(hash['CreditCard'])
        @installments = hash['Installments']
        @interest = hash['Interest']
        @links = KCielo::Response::Default::Link.build_array(hash['Links'])
        @payment_id = hash['PaymentId']
        @reason_code = hash['ReasonCode']
        @reason_message = hash['ReasonMessage']
        @service_tax_amount = hash['ServiceTaxAmount']
        @proof_of_sale = hash['ProofOfSale']
        @authorization_code = hash['AuthorizationCode']
        @provider_return_code = hash['ProviderReturnCode']
        @provider_return_message = hash['ProviderReturnMessage']
        @tid = hash['Tid']
        @return_code = hash['ReturnCode']
      end
    end
  end
end
