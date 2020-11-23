module KCielo
  module Response
    class Cancel
      include KCielo::Pagador
      attr_reader :request_id, :status, :reason_code, :reason_message,
                  :provider_return_code, :provider_return_message, :links

      def initialize(hash)
        @request_id = hash['RequestId']
        @status = hash['Status']
        @reason_code = hash["ReasonCode"]
        @reason_message = hash["ReasonMessage"]
        @provider_return_code = hash["ProviderReturnCode"]
        @provider_return_message = hash["ProviderReturnMessage"]
        @links = Default::Link.build_array(hash["Links"])
      end

      def self.build_response(response)
        if response.kind_of? Net::HTTPSuccess
          build_success_response(response)
        else
          build_error_response(response)
        end
      end

      def success?
        @success ||= operation_success?(@status)
      end

      def messages
        unless @messages
          @messages = []
          @messages << reason_message
          @messages << provider_message if exists_provider_message?
        end
        @messages
      end

      private
      def self.body_parse(body)
        parsed = eval_body_parser body
        parsed = json_body_parser body if parsed.nil?
        parsed
      end

      def self.eval_body_parser(body)
        begin
          return eval(body)
        rescue Exception => e
          nil
        end
      end

      def self.json_body_parser(body)
        begin
          return JSON.parse(body)
        rescue Exception => e
          nil
        end
      end

      def self.build_success_response(response)
        body = body_parse(response.body)
        body['RequestId'] = response['RequestId']
        send(:new, body)
      end

      def self.build_error_response(response)
        body = body_parse(response.body)
        body = build_error_empty_body_response(response) if body.nil?
        body << response['RequestId']
        KCielo::Response::Default::Errors.new(body)
      end

      def self.build_error_empty_body_response(response)
        [{'Code' => "[HTTP-ERROR] #{response.code}", 'Message' => response.message}]
      end

      def reason_message
        return REASON_MESSAGE[@reason_code] if REASON_MESSAGE.key? @reason_code
        "#{@reason_code} - #{REASON_MESSAGE[@reason_code]}"
      end

      def provider_message
        "#{@provider_return_code} - #{@provider_return_message}"
      end

      def exists_provider_message?
        !@provider_return_code.nil?
      end
    end
  end
end
