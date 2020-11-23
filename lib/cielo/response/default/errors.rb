module KCielo
  module Response
    module Default

      class Errors
        attr_reader :messages, :request_id

        include KCielo::Pagador

        def initialize(array)
          @messages = []
          @request_id = array.last
          array.delete array.last
          array.each do |error|
            @messages << build_error_message(error)
          end
        end

        def transaction_created?
          @transaction_created ||= false
        end

        def success?
          @success ||= false
        end

        private
        def build_error_message(error)
          code = error['Code']
          return ERROR_MESSAGE[code] if ERROR_MESSAGE.key? code
          "#{code} - #{error['Message']}"
        end
      end
    end
  end
end
