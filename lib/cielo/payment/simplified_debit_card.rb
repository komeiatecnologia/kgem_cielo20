module KCielo
  module Payment
    class SimplifiedDebitCard < KCielo::Request::SimplifiedDebitCard

      def pay
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::SimplifiedDebitCard.new
        @ws_client.send_request(self)
      end
    end
  end
end
