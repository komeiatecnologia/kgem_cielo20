module KCielo
  module Response
    class SimplifiedCreditCard < KCielo::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @customer = KCielo::Response::Default::Customer.new(hash['Customer'])
        @payment = KCielo::Response::PaymentWithCreditCard.new(hash['Payment'])
      end

      def paid?
        @paid ||= credit_card_paid?(@payment.status)
      end
    end
  end
end
