require 'test/helpers/test_helper'

class CreditCardTest < Test::Unit::TestCase

  def test_should_throw_exception_if_brand_class_different_of_symbol
    c = new_debit_card
    begin
      b = "visa"
      c.brand = b
    rescue Exception => e
      assert_equal c.msg_invalid_class("brand", Symbol), e.message
    end
  end

  def test_should_throw_exception_if_brand_not_registered
    c = new_debit_card
    begin
      b = :bandeira
      c.brand = b
    rescue Exception
      assert_equal true, true
    end
  end

  def test_should_return_brand_equal_Visa
    c = new_debit_card
    c.brand = :visa
    assert_equal "Visa", c.brand
  end

  def test_should_return_brand_equal_Master
    c = new_debit_card
    c.brand = :mastercard
    assert_equal "Master", c.brand
  end

  def test_should_convert_credit_card_to_cielo_hash_format
    c = new_debit_card

    card_number = "1111222233334444"
    c.card_number = card_number

    holder = "José da Silva"
    c.holder = holder

    expiration_date = "10/2020"
    c.expiration_date = expiration_date

    security_code = "123"
    c.security_code = security_code

    brand = :visa
    c.brand = brand

    cielo_hash = c.to_cielo_hash

    assert_equal(card_number, cielo_hash["CardNumber"])
    assert_equal(holder, cielo_hash['Holder'])
    assert_equal(expiration_date, cielo_hash['ExpirationDate'])
    assert_equal(security_code, cielo_hash['SecurityCode'])
    assert_equal("Visa", cielo_hash['Brand'])
  end

private
  def new_debit_card
    KCielo::Request::Default::DebitCard.new
  end
end
