module KCielo
  module Request
    class Pix < KCielo::Request::Default::Request
      def initialize
        send(:customer=, KCielo::Request::Default::Customer.new)
        send(:payment=, KCielo::Request::Default::PaymentWithPix.new)
      end
    end
  end
end
