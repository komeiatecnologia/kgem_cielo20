module KCielo
  module Response
    class Query

      PATTERNS = {
        :payment_slip => /"Type"(| ):(| )"Boleto"/,
        :credit_card => /"Type"(| ):(| )"CreditCard"/,
        :debit_card => /"Type"(| ):(| )"DebitCard"/
      }

      BUILDERS = {
        :error => KCielo::Response::Default::Response,
        :credit_card => KCielo::Response::SimplifiedCreditCard,
        :debit_card => KCielo::Response::SimplifiedDebitCard,
        :payment_slip => KCielo::Response::CompletePaymentSlip
      }

      def self.build_response(response)
        if response.kind_of? Net::HTTPSuccess
          body_parser(response.body).build_response(response)
        else
          response = ganbiarra(response) if response.code == '404'
          BUILDERS[:error].build_response(response)
        end
      end

      private
      def self.body_parser(body)
        PATTERNS.each do |k,v|
          return BUILDERS[k] if v =~ body
        end
      end

      # Para dar um retorno mais preciso quando não encontrar o pagamento consultado
      def self.ganbiarra(response)
        def response.body
          '[{
            "Code": 307,
            "Message": "Transaction not found"
          }]'
        end
        response
      end
    end
  end
end
