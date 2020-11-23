module KCielo
  module WebService
    class CompletePaymentSlip

      def initialize
        @rest_client = KCielo::WebService::RestClient.new
      end

      def send_request(cps_request)
        req = @rest_client.post(url, cps_request.to_cielo_hash)
        format_response(req.request)
      end

      def format_response(response)
        KCielo::Response::CompletePaymentSlip.build_response(response)
      end

      private
      def url
        @@URL ||= KCielo.payment_url + KCielo.complete_payment_slip_resource
      end
    end
  end
end
