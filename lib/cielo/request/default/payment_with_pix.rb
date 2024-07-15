module KCielo
  module Request
    module Default
      class PaymentWithPix < KCielo::Request::Default::Payment
        def initialize
          super
          send(:type=, :pix)
        end
      end
    end
  end
end
