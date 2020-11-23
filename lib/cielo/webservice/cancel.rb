module KCielo
  module WebService
    class Cancel
      def initialize
        @rest_client = KCielo::WebService::RestClient.new
      end

      def send_request(payment_id, amount = nil)
        req = @rest_client.put(url(payment_id, amount))
        format_response(req.request)
      end

      private
      def url(payment_id, amount)
        url = "#{KCielo.payment_url}#{KCielo.cancel_resource}"
        url << "#{payment_id}/void"
        url << "?amount=#{amount}" if amount
        url
      end

      def format_response(response)
        KCielo::Response::Cancel.build_response(response)
      end
    end
  end
end
