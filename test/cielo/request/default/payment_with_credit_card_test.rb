require 'test/helpers/test_helper'

class PaymentWithCreditCardTest < Test::Unit::TestCase

  def test_should_return_payment_with_credit_card_class
    p = new_payment_with_credit_card

    assert_equal KCielo::Request::Default::CreditCard, p.credit_card.class
  end

  def test_should_convert_payment_with_credit_card_to_cielo_hash_format
    p = new_payment_with_credit_card
    p.installments = 6

    hash = p.to_cielo_hash
    assert_equal Hash, hash['CreditCard'].class
    assert_equal "ByIssuer", hash['Interest']
    assert_equal(6, hash["Installments"])
  end

    def test_installments_should_greater_than_zero
    p = new_payment_with_credit_card
    p.installments = 10
    assert_equal(10, p.installments)

    begin
      p.installments = -1
    rescue Exception => e
      assert_equal p.msg_less_or_equal_zero(-1), e.message
    end

    begin
      p.installments = 0
    rescue Exception => e
      assert_equal p.msg_less_or_equal_zero(0), e.message
    end
  end

  def test_should_throw_exception_when_installment_is_a_fractional_number
    p = new_payment_with_credit_card
    installments = 1.2
    begin
      p.installments = installments
    rescue Exception => e
      assert_equal p.msg_invalid_class(:installments,Integer), e.message
    end
  end

  private
  def new_payment_with_credit_card
    KCielo::Request::Default::PaymentWithCreditCard.new
  end
end
