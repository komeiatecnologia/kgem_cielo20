module KCielo
  module Response
    module Default

      class PaymentWithPaymentSlip < KCielo::Response::Default::Payment
        attr_reader :instructions, :expiration_date, :url, :number, :bar_code_number
        attr_reader :digitable_line, :assignor, :address, :identification
        attr_reader :payment_id, :reason_code, :reason_message, :links, :return_code

        def initialize(hash)
          super(hash)
          @instructions = hash['Instructions']
          @expiration_date = hash['ExpirationDate']
          @url = hash['Url']
          @number = hash['Number']
          @bar_code_number = hash['BarCodeNumber']
          @digitable_line = hash['DigitableLine']
          @assignor = hash['Assignor']
          @address = hash['Address']
          @payment_id = hash['PaymentId']
          @reason_code = hash['ReasonCode']
          @reason_message = hash['ReasonMessage']
          @links = KCielo::Response::Default::Link.build_array(hash['Links'])
          @return_code = hash['ReturnCode']
        end
      end
    end
  end
end
