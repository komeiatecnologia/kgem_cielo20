require 'test/helpers/test_helper'

class SimplifiedDebitCardTest < Test::Unit::TestCase

  def test_should_return_valid_instance_of_simplified_credit_card_request
    sdc = new_sdc
    assert_equal(correct_payment_class, sdc.payment.class)
    assert_equal(correct_customer_class, sdc.customer.class)
    assert_equal(true, sdc.kind_of?(correct_ancestor_class))
  end

  def test_should_convert_to_cielo_hash_format
    sdc = new_sdc
    hash = sdc.to_cielo_hash
    assert_equal(Hash, hash['Customer'].class)
    assert_equal(Hash, hash['Payment'].class)
    assert_equal(Hash, hash['Payment']['DebitCard'].class)
    assert_equal(true, hash.key?('MerchantOrderId'))
  end

  private
  def new_sdc
    KCielo::Request::SimplifiedDebitCard.new
  end

  def correct_payment_class
    KCielo::Request::Default::PaymentWithDebitCard
  end

  def correct_customer_class
    KCielo::Request::Default::Customer
  end

  def correct_ancestor_class
    KCielo::Request::Default::Request
  end
end
