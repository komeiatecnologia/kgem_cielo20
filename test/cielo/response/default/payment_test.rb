require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_payment'

class PaymentTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_payment_object
    fake = FakePayment.new.default_hash
    payment = KCielo::Response::Default::Payment.new(fake)

    each_expected_and_returned(fake, payment) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
