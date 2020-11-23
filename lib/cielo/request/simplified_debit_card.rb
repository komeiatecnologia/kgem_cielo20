module KCielo
  module Request

    class SimplifiedDebitCard < KCielo::Request::Default::Request

      def initialize
        send(:payment=, KCielo::Request::Default::PaymentWithDebitCard.new)
        send(:customer=, KCielo::Request::Default::Customer.new)
      end

    end
  end
end
