module KCielo
  module WebService
    class RestClient

      @@REGEX_UUID = /^(\w{8})(\w{4})(\w{4})(\w{4})(\w{12}).*/.freeze
      @@DEFAULT_METHODS = { :get => Net::HTTP::Get,
                            :post => Net::HTTP::Post,
                            :put => Net::HTTP::Put,
                            :delete => Net::HTTP::Delete
                          }

      def initialize
        @req = nil
      end

      def get(resource)
        build_request(:get, resource)
        self
      end

      def post(resource, params)
        build_request(:post, resource, params)
        self
      end

      def put(resource, params = nil)
        build_request(:put, resource, params)
        self
      end

      def patch(resource, params = nil)
        build_request(:patch, resource, params)
        self
      end

      def delete(resource)
        build_request(:delete, resource)
        self
      end

      def request
        send_request
      end

      private
      def build_request(method, resource, params = nil)
        uri = URI(resource)
        @https = new_https(uri)
        @req = new_request(method, uri)
        params ? @req.body = params.to_json : @req.body = "{}"
        logger.log_request(@req, uri)
      end

      def send_request
        response = nil
        KCielo.connection_attempts.times do |i|
          begin
            response = @https.request(@req)
            logger.log_response(response)
            break unless response.nil?
          rescue Exception => e
            logger.log "#{e.class}: #{e.message}"
          end
        end
        response
      end

      def new_request(method, uri)
        @@DEFAULT_METHODS[method].new(uri.path, header)
      end

      def new_https(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER
        http.ca_file = KCielo.ca_file_path if cert_exist?
        http.read_timeout = KCielo.timeout
        http
      end

      def header
        @HEADER ||= {
         "Content-Type" => "text/json",
         "MerchantId" => KCielo.merchant_id,
         "MerchantKey" => KCielo.merchant_key
        }
        @HEADER["RequestId"] = generate_uuid
        @HEADER
      end

      def generate_uuid
        uuid = SecureRandom.hex(16)
        "#{$1}-#{$2}-#{$3}-#{$4}-#{$5}" unless uuid !~ @@REGEX_UUID
      end

      def logger
        KLog::Log.new
      end

      def cert_exist?
        valid = File.exist?(KCielo.ca_file_path) if KCielo.ca_file_path
        raise(
              ArgumentError,
              "certificate ssl not found, configure in KCielo.ca_file_path=, for more information read README file"
              ) unless valid
        valid
      end
    end
  end
end
