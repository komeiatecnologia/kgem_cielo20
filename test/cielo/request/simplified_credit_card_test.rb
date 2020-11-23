require 'test/helpers/test_helper'

class SimplifiedCreditCardTest < Test::Unit::TestCase

  def test_should_return_valid_instance_of_simplified_credit_card_request
    scc = new_scc
    assert_equal(correct_payment_class, scc.payment.class)
    assert_equal(correct_customer_class, scc.customer.class)
    assert_equal(true, scc.kind_of?(correct_ancestor_class))
  end

  def test_should_convert_to_cielo_hash_format
    scc = new_scc
    hash = scc.to_cielo_hash
    assert_equal(Hash, hash['Customer'].class)
    assert_equal(Hash, hash['Payment'].class)
    assert_equal(Hash, hash['Payment']['CreditCard'].class)
    assert_equal(true, hash.key?('MerchantOrderId'))
  end

  private
  def new_scc
    KCielo::Request::SimplifiedCreditCard.new
  end

  def correct_payment_class
    KCielo::Request::Default::PaymentWithCreditCard
  end

  def correct_customer_class
    KCielo::Request::Default::Customer
  end

  def correct_ancestor_class
    KCielo::Request::Default::Request
  end
end
