module KCielo
  module Request
    class CompletePaymentSlip < KCielo::Request::Default::Request
      def initialize
        send(:customer=, KCielo::Request::Default::Customer.new)
        send(:payment=, KCielo::Request::Default::PaymentWithCompletePaymentSlip.new)
      end
    end
  end
end
