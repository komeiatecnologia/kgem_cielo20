require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_payment_with_credit_card'

require 'cielo/response/default/link'

class PaymentWithCreditCardTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [KCielo::Response::Default::CreditCard,
                    Array]

  def test_should_convert_default_hash_to_payment_with_credit_card_object
    pwcc = fake_object
    each_expected_and_returned(fake_hash, pwcc) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_array_link_objects
    links = fake_object.links
    links.each do |link|
      assert_equal(valid_link_class, link.class)
    end
  end

  def test_should_return_valid_credit_card_class
    cc = fake_object.credit_card
    assert_equal(valid_credit_card_class, cc.class)
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_object
    KCielo::Response::PaymentWithCreditCard.new(fake_hash)
  end

  def fake_hash
    FakePaymentWithCreditCard.new.default_hash
  end

  def valid_link_class
    KCielo::Response::Default::Link
  end

  def valid_credit_card_class
    KCielo::Response::Default::CreditCard
  end
end
