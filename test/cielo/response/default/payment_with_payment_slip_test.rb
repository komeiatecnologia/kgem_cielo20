require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_payment_with_payment_slip'

class PaymentWithPaymentSlipTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [Array]

  def test_should_convert_default_hash_to_payment_with_payment_slip_object
    each_expected_and_returned(fake_hash, fake_object) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_valid_array_link_class
    links = fake_object.links

    links.each do |link|
      assert_equal(valid_link_class, link.class)
    end
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_hash
    FakePaymentWithPaymentSlip.new.default_hash
  end

  def fake_object
    KCielo::Response::Default::PaymentWithPaymentSlip.new(fake_hash)
  end

  def valid_link_class
    KCielo::Response::Default::Link
  end
end
