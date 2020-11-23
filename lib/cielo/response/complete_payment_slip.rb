module KCielo
  module Response
    class CompletePaymentSlip < KCielo::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @payment = Default::PaymentWithPaymentSlip.new(hash['Payment'])
        @customer = Default::Customer.new(hash['Customer'])
      end

      def paid?
        @paid ||= payment_slip_paid?(@payment.status)
      end
    end
  end
end
