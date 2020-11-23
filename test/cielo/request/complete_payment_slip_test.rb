require 'test/helpers/test_helper'

class CompletePaymentSlipTest < Test::Unit::TestCase

  def test_should_return_valid_instance_of_complete_payment_slip
    cps = new_cps
    assert_equal(correct_payment_class, cps.payment.class)
    assert_equal(correct_customer_class, cps.customer.class)
    assert_equal(true, cps.kind_of?(correct_ancestor_class))
  end

  def test_should_convert_to_cielo_hash_format
    cps = new_cps
    hash = cps.to_cielo_hash
    assert_equal(Hash, hash['Customer'].class)
    assert_equal(Hash, hash['Payment'].class)
    assert_equal(true, hash.key?('MerchantOrderId'))
  end

  def test_should_throw_invalid_address_size
    cps = new_cps
    begin
      cps.payment.address = "Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres
       Sou maior que 255 caracteres"
    rescue Exception => e
      assert_equal("address longer than 255 characters", e.message)
    end
  end

  def test_should_throw_invalid_payment_slip_number
    cps = new_cps
    begin
      cps.payment.payment_slip_number = "abc"
    rescue Exception => e
      assert_equal("Invalid payment slip number, expected max string with 1..50 numeric characters", e.message)
    end
  end

  private
  def new_cps
    KCielo::Request::CompletePaymentSlip.new
  end

  def correct_payment_class
    KCielo::Request::Default::PaymentWithCompletePaymentSlip
  end

  def correct_customer_class
    KCielo::Request::Default::Customer
  end

  def correct_ancestor_class
    KCielo::Request::Default::Request
  end

end
