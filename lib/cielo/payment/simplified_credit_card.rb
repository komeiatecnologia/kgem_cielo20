module KCielo
  module Payment
    class SimplifiedCreditCard < KCielo::Request::SimplifiedCreditCard

      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::SimplifiedCreditCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
