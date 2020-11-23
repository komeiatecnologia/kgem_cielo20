module KCielo
  module Request

    class SimplifiedCreditCard < KCielo::Request::Default::Request

      def initialize
        send(:payment=, KCielo::Request::Default::PaymentWithCreditCard.new)
        send(:customer=, KCielo::Request::Default::Customer.new)
      end

    end
  end
end
