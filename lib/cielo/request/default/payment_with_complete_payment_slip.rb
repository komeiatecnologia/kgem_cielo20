module KCielo
  module Request
    module Default
      class PaymentWithCompletePaymentSlip < KCielo::Request::Default::PaymentWithPaymentSlip
        include KCielo::Helpers
        extend KCielo::HelpersClass

        can_be_nil :address, :payment_slip_number, :assignor, :demonstrative,
                   :expiration_date, :instructions, :identification

        attr_reader :address, :assignor, :demonstrative, :expiration_date,
                    :instructions, :payment_slip_number, :identification

        def initialize
          super
          @address = nil
          @assignor = nil
          @demonstrative = nil
          @expiration_date = nil
          @identification = nil
          @instructions = nil
          @payment_slip_number = nil # Nosso número
        end

        def address=(address)
          @address = address if valid_address?(address)
        end

        def assignor=(assignor)
          @assignor = assignor if valid_assignor?(assignor)
        end

        def demonstrative=(demonstrative)
          @demonstrative = demonstrative if valid_demonstrative?(demonstrative)
        end

        def expiration_date=(expiration_date)
          @expiration_date = expiration_date if valid_expiration_date?(expiration_date)
        end

        def identification=(identification)
          @identification = identification if valid_identification?(identification)
        end

        def instructions=(instructions)
          @instructions = instructions if valid_instructions?(instructions)
        end

        def payment_slip_number=(payment_slip_number)
          @payment_slip_number = payment_slip_number if valid_payment_slip_number?(payment_slip_number)
        end

        def to_cielo_hash
          h = super
          h['Address'] = @address
          h['BoletoNumber'] = @payment_slip_number
          h['Assignor'] = @assignor
          h['Demonstrative'] = @demonstrative
          h['ExpirationDate'] = @expiration_date
          h['Identification'] = @identification
          h['Instructions'] = @instructions
          h
        end

        private
        def valid_address?(address)
          valid_class_type_?(:address, address, String) && present_?(address, "address")
        end

        def valid_assignor?(assignor)
          valid_class_type_?(:assignor, assignor, String) && present_?(assignor, "assignor")
        end

        def valid_demonstrative?(demonstrative)
          valid_class_type_?(:demonstrative, demonstrative, String) && present_?(demonstrative, "demonstrative")
        end

        def valid_expiration_date?(expiration_date)
          valid_class_type_?(:expiration_date, expiration_date, String) && present_?(expiration_date, "expiration_date") && greater_than_current_date_?(expiration_date)
        end

        def valid_identification?(identification)
          present_?(identification, 'identification') && valid_class_type_?(:identification, identification, String) && valid_identification_format?(identification)
        end

        def valid_instructions?(instructions)
          valid_class_type_?(:instructions, instructions, String) && present_?(instructions, "instructions")
        end

        def valid_payment_slip_number?(payment_slip_number)
          valid_class_type_?(:payment_slip_number, payment_slip_number, String) && present_?(payment_slip_number, "payment_slip_number") && valid_payment_slip_format?(payment_slip_number)
        end

        def valid_payment_slip_format?(payment_slip_number)
          @@VALID_PAYMENT_SLIP_NUMBER ||= /^\d{1,50}$/
          raise ArgumentError, "Invalid payment slip number, expected max string with 1..50 numeric characters", "#{self.class}" if payment_slip_number !~ @@VALID_PAYMENT_SLIP_NUMBER
          true
        end
      end
    end
  end
end
