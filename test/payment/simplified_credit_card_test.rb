require 'test/helpers/test_helper'
require 'test/fake_object/request/fake_simplified_credit_card'

class SimplifiedCreditCardTest < Test::Unit::TestCase
  include KCielo::Helpers

  def test_should_throw_merchant_order_id_can_not_be_empty
    scc = fake_obj
    scc.instance_variable_set :@merchant_order_id, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("merchant_order_id"), e.message
    end
  end

  def test_should_throw_customer_name_can_not_be_empty
    scc = fake_obj
    scc.customer.instance_variable_set :@name, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_throw_payment_installments_can_not_be_empty
    scc = fake_obj
    scc.payment.instance_variable_set :@installments, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("installments"), e.message
    end
  end

  def test_should_return_correct_cielo_hash
    scc = fake_obj
    hash = scc.to_cielo_hash
    assert_equal scc.merchant_order_id, hash['MerchantOrderId']
    assert_equal scc.customer.class, KCielo::Request::Default::Customer
    assert_equal scc.customer.name, hash['Customer']['Name']
    assert_equal scc.payment.class, KCielo::Request::Default::PaymentWithCreditCard
    assert_equal scc.payment.amount, hash['Payment']['Amount']
    assert_equal "Simulado", hash['Payment']['Provider']
    assert_equal "ByIssuer", hash['Payment']['Interest']
    assert_equal scc.payment.installments, hash['Payment']['Installments']
    assert_equal scc.payment.credit_card.class, KCielo::Request::Default::CreditCard
    assert_equal scc.payment.credit_card.card_number, hash['Payment']['CreditCard']['CardNumber']
    assert_equal scc.payment.credit_card.holder, hash['Payment']['CreditCard']['Holder']
    assert_equal scc.payment.credit_card.expiration_date, hash['Payment']['CreditCard']['ExpirationDate']
    assert_equal scc.payment.credit_card.security_code, hash['Payment']['CreditCard']['SecurityCode']
    assert_equal scc.payment.credit_card.brand, hash['Payment']['CreditCard']['Brand']
  end

  def test_should_throw_can_not_be_empty_if_payment_equal_nil
    scc = fake_obj
    scc.instance_variable_set :@payment, nil
    begin
      scc.valid_?
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_can_not_be_empty_if_customer_equal_nil
    scc = fake_obj
    scc.instance_variable_set :@customer, nil
    begin
      scc.valid_?
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("customer"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    scc = fake_obj
    scc.instance_variable_set :@payment, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_payment_can_not_be_empty_when_try_pay
    scc = fake_obj
    scc.instance_variable_set :@payment, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("payment"), e.message
    end
  end

  def test_should_throw_customer_can_not_be_empty_when_try_pay
    scc = fake_obj
    scc.instance_variable_set :@customer, nil
    begin
      scc.pay
    rescue Exception => e
      assert_equal scc.msg_can_not_be_empty("customer"), e.message
    end
  end

  private
  def fake_obj
    scc = KCielo::Payment::SimplifiedCreditCard.new
    FakeSimplifiedCreditCard.default! scc
    scc
  end
end
