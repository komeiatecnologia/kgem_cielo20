module KCielo
  module Payment
    class CompletePaymentSlip < KCielo::Request::CompletePaymentSlip
      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::CompletePaymentSlip.new
        @ws_client.send_request(self)
      end
    end
  end
end
