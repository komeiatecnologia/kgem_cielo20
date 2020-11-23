module KCielo
  module Response
    module Default

      class Response
        include KCielo::Pagador

        attr_reader :merchant_order_id, :request_id

        def initialize(hash)
          @merchant_order_id = hash['MerchantOrderId']
          @request_id = hash['RequestId']
        end

        def transaction_created?
          @transaction_created ||= true
        end

        def success?
          @success ||= operation_success?(@payment.status)
        end

        def canceled?
          @canceled ||= transaction_canceled?(@payment.status)
        end

        def messages
          unless @messages
            @messages = []
            @messages << reason_message
            @messages << @payment.status_message
            @messages << provider_message if exists_provider_message?
          end
          @messages
        end

        def payment_id
          @payment.payment_id
        end

        def self.build_response(response)
          if response.kind_of? Net::HTTPSuccess
            build_success_response(response)
          else
            build_error_response(response)
          end
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
          code = @payment.reason_code
          return_code = @payment.return_code
          return REASON_MESSAGE[code] if REASON_MESSAGE.key? code
          RETURN_CODE_MESSAGE[return_code] if @payment.status != 2 && (RETURN_CODE_MESSAGE.key? return_code)
        end

        def provider_message
          "#{@payment.provider_return_code} - #{@payment.provider_return_message}"
        end

        def exists_provider_message?
          @payment.respond_to?(:provider_return_code) && @payment.provider_return_code
        end
      end
    end
  end
end
