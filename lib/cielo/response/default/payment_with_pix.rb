module KCielo
  module Response
    module Default

      class PaymentWithPix < KCielo::Response::Default::Payment
        attr_reader :qr_code_string, :qrcode_base64_image, :payment_id
        attr_reader :acquirer_transaction_id, :proof_of_sale, :status
        attr_reader :return_code, :return_message

        def initialize(hash)
          super(hash)
          @qr_code_string = hash['QrCodeString']
          @qrcode_base64_image = hash['QrcodeBase64Image']
          @payment_id = hash['PaymentId']
          @tid = hash['AcquirerTransactionId']
          @proof_of_sale = hash['ProofOfSale']
          @status = hash['Status']
          @return_code = hash['ReturnCode']
          @return_message = hash['ReturnMessage']
        end
      end
    end
  end
end
