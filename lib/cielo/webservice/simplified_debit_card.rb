module KCielo
  module WebService
    class SimplifiedDebitCard

      def initialize
        @rest_client = KCielo::WebService::RestClient.new
      end

      def send_request(sdc_request)
        req = @rest_client.post(url, sdc_request.to_cielo_hash)
        format_response(req.request)
      end

      private
      def url
        @@URL ||= KCielo.payment_url + KCielo.simplified_debit_card_resource
      end

      def format_response(response)
        KCielo::Response::SimplifiedDebitCard.build_response(response)
      end
    end
  end
end
