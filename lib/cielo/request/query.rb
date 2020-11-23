module KCielo
  module Request
    class Query
      include KCielo::Helpers

      attr_reader :payment_id

      def initializer
        @payment_id = nil
      end

      def payment_id=(payment_id)
        @payment_id = payment_id if valid_payment_id?(payment_id)
      end

      def valid_?
        present_?(@payment_id, :payment_id)
      end

      private
      def valid_payment_id?(payment_id)
        valid_class_type_?("payment_id", payment_id, String)
        valid_payment_id_format?(payment_id)
      end
    end
  end
end
