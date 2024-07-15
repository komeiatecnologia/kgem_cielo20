module KCielo
  module Payment
    class Pix < KCielo::Request::Pix
      def pay
        send_request
      end

      private
      def send_request
        @ws_client ||= KCielo::WebService::Pix.new
        @ws_client.send_request(self)
      end
    end
  end
end
