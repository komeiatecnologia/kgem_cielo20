require 'test/helpers/test_helper'

class CardTest < Test::Unit::TestCase

  def test_should_throw_exception_if_card_number_class_different_of_string
    c = new_card
    begin
      n = 1234566
      c.card_number = n
    rescue Exception => e
      assert_equal c.msg_invalid_class('card_number',String), e.message
    end

    begin
      n = 1.2
      c.card_number =n
    rescue Exception => e
      assert_equal c.msg_invalid_class('card_number',String), e.message
    end
  end

  def test_should_throw_exception_when_invalid_card_number_format
    c = new_card
    begin
      n = "0000000011111"
      c.card_number = n
    rescue Exception => e
      assert_equal "Invalid card number format: #{n}, expected 11112222333344??(14 or 16 digits)", e.message
    end

    begin
      n = ""
      c.card_number = n
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("card_number"), e.message
    end
  end

  def test_should_return_card_number_equals_0000111122223333
    c = new_card
    # 16 digits
    c.card_number = "0000111122223333"
    assert_equal "0000111122223333", c.card_number
  end

  def test_should_return_card_number_equals_00001111222233
    c = new_card
    # 14 digits
    c.card_number = "00001111222233"
    assert_equal "00001111222233", c.card_number
  end

  def test_should_throw_exception_if_holder_class_different_of_string
    begin
      c = new_card
      h = :teste
      c.holder = h
    rescue Exception => e
      assert_equal c.msg_invalid_class('holder', String), e.message
    end

    begin
      c = new_card
      h = 234234
      c.holder = h
    rescue Exception => e
      assert_equal c.msg_invalid_class('holder',String), e.message
    end
  end

  def test_should_throw_exception_if_holder_empty
    begin
      c = new_card
      c.holder = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("holder"), e.message
    end
  end

  def test_should_return_holder_equals_Jon_Doe
    c = new_card
    h = "Jon Doe"
    c.holder = h
    assert_equal h, c.holder
  end

  def test_should_throw_exception_if_expiration_date_class_different_of_string
    c = new_card
    begin
      d = Time.now
      c.expiration_date = d
    rescue Exception => e
      assert_equal c.msg_invalid_class('expiration_date', String), e.message
    end
  end

  def test_should_throw_exception_if_expiration_date_empty
    c = new_card
    begin
      a = ""
      c.expiration_date = a
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("expiration_date"), e.message
    end
  end

  def test_should_return_expiration_date_equal_1_slash_2020
    c = new_card
    d = "1/2020"
    c.expiration_date = d
    assert_equal d, c.expiration_date
  end

  def test_should_return_expiration_date_equal_11_slash_2020
    c = new_card
    d = "11/2020"
    c.expiration_date = d
    assert_equal d, c.expiration_date
  end

  def test_should_throw_exception_if_security_code_class_different_of_string
    c = new_card
    begin
      s = 123
      c.security_code = 123
    rescue Exception => e
      assert_equal c.msg_invalid_class('security_code', String), e.message
    end
  end

  def test_should_throw_exception_if_security_code_empty
    c = new_card
    begin
      s = ""
      c.security_code = s
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("security_code"), e.message
    end
  end

  def test_should_return_security_code_equal_123
    c = new_card
    s = "666"
    c.security_code = s
    assert_equal s, c.security_code
  end

private
  def new_card
    KCielo::Request::Default::Card.new
  end
end
