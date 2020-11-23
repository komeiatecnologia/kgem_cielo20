require 'test/helpers/test_helper'
require 'test/fake_object/request/fake_complete_payment_slip'

class CompletePaymentSlipTest < Test::Unit::TestCase
  include KCielo::Helpers

  def test_should_throw_customer_name_can_not_be_empty
    cps = fake_obj
    cps.customer.instance_variable_set(:@name, nil)
    begin
      cps.pay
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_throw_merchant_order_id_can_not_be_empty
    cps = fake_obj
    cps.instance_variable_set(:@merchant_order_id, nil)
    begin
      cps.pay
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("merchant_order_id"), e.message
    end
  end

  def test_should_return_correct_cielo_hash
    cps = fake_obj
    hash = cps.to_cielo_hash
    assert_equal cps.merchant_order_id, hash['MerchantOrderId']
    assert_equal cps.customer.class, KCielo::Request::Default::Customer
    assert_equal cps.customer.name, hash['Customer']['Name']
    assert_equal cps.customer.identity, hash['Customer']['Identity']
    assert_equal cps.payment.class, KCielo::Request::Default::PaymentWithCompletePaymentSlip
    assert_equal cps.payment.amount, hash['Payment']['Amount']
    assert_equal cps.payment.provider, hash['Payment']['Provider']
    assert_equal cps.payment.address, hash['Payment']['Address']
    assert_equal cps.payment.payment_slip_number, hash['Payment']['BoletoNumber']
    assert_equal cps.payment.assignor, hash['Payment']['Assignor']
    assert_equal cps.payment.demonstrative, hash['Payment']['Demonstrative']
    assert_equal cps.payment.expiration_date, hash['Payment']['ExpirationDate']
    assert_equal cps.payment.instructions, hash['Payment']['Instructions']
  end

  def test_should_throw_can_not_be_empty_if_payment_equal_nil
    cps = fake_obj
    cps.instance_variable_set :@payment, nil
    begin
      cps.valid_?
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_can_not_be_empty_if_customer_equal_nil
    cps = fake_obj
    cps.instance_variable_set :@customer, nil
    begin
      cps.valid_?
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("customer"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    cps = fake_obj
    cps.instance_variable_set :@payment, nil
    begin
      cps.pay
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_customer_can_not_be_empty_when_try_pay
    cps = fake_obj
    cps.instance_variable_set :@customer, nil
    begin
      cps.pay
    rescue Exception => e
      assert_equal cps.msg_can_not_be_empty("customer"), e.message
    end
  end

  private
  def fake_obj
    cps = KCielo::Payment::CompletePaymentSlip.new
    FakeCompletePaymentSlip.default! cps
    cps
  end
end
