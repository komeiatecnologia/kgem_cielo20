module KCielo
  module Payment
    class Cancel < KCielo::Request::Cancel
      def cancel(id = nil, a = nil)
        self.payment_id = id unless id.nil?
        self.amount = a unless a.nil?

        send_request if valid_?
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::Cancel.new
        @ws_client.send_request(@payment_id, @amount)
      end
    end
  end
end
