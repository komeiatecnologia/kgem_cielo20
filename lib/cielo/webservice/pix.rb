module KCielo
  module WebService
    class Pix

      def initialize
        @rest_client = KCielo::WebService::RestClient.new
      end

      def send_request(pix_request)
        req = @rest_client.post(url, pix_request.to_pix_hash)
        format_response(req.request)
      end

      def format_response(response)
        KCielo::Response::Pix.build_response(response)
      end

      private
      def url
        @@URL ||= KCielo.payment_url + KCielo.pix_resource
      end
    end
  end
end
