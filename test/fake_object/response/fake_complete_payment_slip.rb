require 'test/fake_object/response/fake_payment_with_payment_slip'
require 'test/fake_object/response/fake_customer'

class FakeCompletePaymentSlip
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    {
      'Customer' => FakeCustomer.new.default_hash,
      'MerchantOrderId' => "2014111706",
      'Payment' => FakePaymentWithPaymentSlip.new.default_hash
    }
  end
end
