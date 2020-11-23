module KCielo
  module WebService
    class SimplifiedCreditCard

      def initialize
        @rest_client = KCielo::WebService::RestClient.new
      end

      def send_request(scc_request)
        req = @rest_client.post(url, scc_request.to_cielo_hash)
        format_response(req.request)
      end

      private
      def url
        @@URL ||= KCielo.payment_url + KCielo.simplified_credit_card_resource
      end

      def format_response(response)
        KCielo::Response::SimplifiedCreditCard.build_response(response)
      end
    end
  end
end
