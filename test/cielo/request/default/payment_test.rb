require 'test/helpers/test_helper'

class PaymentTest < Test::Unit::TestCase

  def test_type_receive_string_should_be_equal_Boleto
    p = new_payment
    p.type = "Boleto"
    assert_equal("Boleto", p.type)
  end

  def test_type_receive_string_should_be_equal_CreditCard
    p = new_payment
    p.type = "CreditCard"
    assert_equal("CreditCard", p.type)
  end

  def test_type_receive_string_should_be_equal_DebitCard
    p = new_payment
    p.type = "DebitCard"
    assert_equal("DebitCard", p.type)
  end

  # def test_type_receive_string_should_be_equal_EletronicTransfer
  #   p = new_payment
  #   p.type = "EletronicTransfer"
  #   assert_equal("EletronicTransfer", p.type)
  # end

  def test_type_should_be_equal_Boleto
    p = new_payment
    p.type = :payment_slip
    assert_equal "Boleto", p.type
  end

  def test_type_should_be_equal_CreditCard
    p = new_payment
    p.type = :credit_card
    assert_equal "CreditCard", p.type
  end

  def test_type_should_be_equal_DebitCard
    p = new_payment
    p.type = :debit_card
    assert_equal "DebitCard", p.type
  end

  # def test_type_should_be_equal_EletronicTransfer
  #   p = new_payment
  #   p.type = :eletronic_transfer
  #   assert_equal "EletronicTransfer", p.type
  # end

  def test_should_show_setence_with_all_payment_types
    begin
      p = new_payment
      p.type = :payment_key
    rescue Exception => e
      assert_equal "Not exists payment_key in: ", e.message.gsub(/\{.*\}/, '')
    end
  end

  def test_should_be_greater_than_zero_the_amount
    begin
      p = new_payment
      p.amount = 0
    rescue Exception => e
      assert_equal p.msg_less_or_equal_zero(0), e.message
    end
  end

  def test_should_be_positive_the_value_of_the_amount
    begin
      p = new_payment
      p.amount = -1
    rescue Exception => e
      assert_equal p.msg_less_or_equal_zero(-1), e.message
    end
  end

  def test_amount_should_be_integer_when_receives_a_float
    p = new_payment

    p.amount = 1000.00
    assert_equal 100000, p.amount

    p.amount = 1000.01
    assert_equal 100001, p.amount
  end

  def test_amount_should_be_integer_when_receives_a_string
    p = new_payment

    p.amount= "1.00"
    assert_equal(100, p.amount)

    p.amount = "1.02"
    assert_equal(102, p.amount)
  end

  def test_amount_should_be_integer_when_receives_a_bigdecimal
    p = new_payment

    p.amount = BigDecimal.new("10.00")
    assert_equal 1000, p.amount

    p.amount = BigDecimal.new("101.01")
    assert_equal 10101, p.amount

    p.amount  = BigDecimal.new("1010.20")
    assert_equal 101020, p.amount
  end

  def test_should_throw_exeception_when_provider_class_not_is_symbol
    p = new_payment
    assert_equal false, p.respond_to?(:provider=)
  end

  def test_should_convert_self_to_cielo_hash
    p = new_payment
    p.type = :credit_card
    p.amount = 10010

    hash = p.to_cielo_hash
    assert_equal("CreditCard", hash["Type"])
    assert_equal(10010, hash["Amount"])
  end

  private
  def new_payment
    KCielo::Request::Default::Payment.new
  end
end
