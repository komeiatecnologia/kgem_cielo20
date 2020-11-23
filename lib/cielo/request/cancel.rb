module KCielo
  module Request

    class Cancel
      include KCielo::Helpers

      attr_reader :payment_id, :amount

      def initialize
        @amount = nil
        @payment_id = nil
      end

      def amount=(amount)
        amount = standardize_amount(amount)
        @amount = amount if valid_amount?(amount)
      end

      def payment_id=(payment_id)
        @payment_id = payment_id if valid_payment_id?(payment_id)
      end

      def valid_?
        present_?(payment_id, "payment_id")
      end

      private
      def valid_amount?(amount)
        greater_than_zero_?(amount)
      end

      def valid_payment_id?(payment_id)
        valid_class_type_?("payment_id", payment_id, String)
        valid_payment_id_format?(payment_id)
      end

    end
  end
end
