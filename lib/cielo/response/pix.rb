module KCielo
  module Response
    class Pix < KCielo::Response::Default::Response
      attr_reader :payment, :customer

      def initialize(hash)
        super(hash)
        @payment = Default::PaymentWithPix.new(hash['Payment'])
        @customer = Default::Customer.new(hash['Customer'])
      end
    end
  end
end
