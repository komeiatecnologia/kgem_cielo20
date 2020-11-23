module KCielo
  module Payment
    class Query < KCielo::Request::Query

      def consult(payment_id = nil)
        self.payment_id = payment_id unless payment_id.nil?
        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::Query.new
        @ws_client.send_request(self)
      end
    end
  end
end
