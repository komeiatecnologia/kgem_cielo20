require 'test/helpers/test_helper'

class DefaultCustomertTest < Test::Unit::TestCase

  def test_should_throw_exception_name_invalid_class_type
    c = new_customer
    begin
      name = :rafael_moraes
      c.name = name
    rescue Exception => e
      assert_equal c.msg_invalid_class(:name, String), e.message
    end
  end

  def test_should_throw_exception_name_can_not_be_empty
    c = new_customer
    begin
      c.name = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty("name"), e.message
    end
  end

  def test_should_return_name_equal_Carlos_Alberto
    c = new_customer
    name = "Carlos Alberto"
    c.name = name
    assert_equal name, c.name
  end

  def test_should_convert_default_customer_to_cielo_hash_format
    c = new_customer

    name = "Carlos Alberto"
    c.name = name

    cielo_hash = c.to_cielo_hash

    assert_equal name, cielo_hash['Name']
  end

  def test_should_throw_exception_identity_invalid_class_type
    c = new_customer
    begin
      id = 1234567890
      c.identity = id
    rescue Exception => e
      assert_equal c.msg_invalid_class(:identity, String), e.message
    end
  end

  def test_should_throw_exception_identity_can_not_be_empty
    c = new_customer
    begin
      c.identity = ""
    rescue Exception => e
      assert_equal c.msg_can_not_be_empty('identity'), e.message
    end
  end

  def test_should_throw_exception_identity_invalid_format
    c = new_customer
    id = "123456789012345"
    begin
      c.identity = id
    rescue Exception => e
      msg = "Invalid identity/identification, expected string with max 14 numeric characters(CPF/CPNJ)"
      assert_equal msg, e.message
    end
  end

  def test_should_throw_exception_identity_invalid_format_for_123_123_123_24
        c = new_customer
    id = "123.123.123.24"
    begin
      c.identity = id
    rescue Exception => e
      msg = "Invalid identity/identification, expected string with max 14 numeric characters(CPF/CPNJ)"
      assert_equal msg, e.message
    end
  end

  def test_should_return_identity_equal_12345678910
    c = new_customer
    id = "12345678910"
    c.identity = id
    assert_equal id, c.identity
  end

  def test_should_throw_exception_identity_type_invalid_class_type
    c = new_customer
    begin
      c.identity_type = :cpf
    rescue Exception => e
      assert_equal c.msg_invalid_class(:identity_type, String), e.message
    end
  end

  def test_should_return_identity_type_equal_CPF
    c = new_customer
    c.identity_type = type = "CPF"
    assert_equal type, c.identity_type
  end

  def test_should_throw_exception_email_invalid_class_type
    c = new_customer
    begin
      c.email = :email
    rescue Exception => e
      assert_equal c.msg_invalid_class(:email, String), e.message
    end
  end

  def test_should_throw_exception_email_invalid_format
    c = new_customer
    begin
      c.email = "teste.com.br"
    rescue Exception => e
      assert_equal "Invalid e-mail format", e.message
    end
  end

  def test_should_return_email_equal_test_domain_com
    c = new_customer
    c.email = email = "test@domain.com"
    assert_equal email, c.email
  end

  def test_should_throw_exception_birthdate_invalid_class_type
    c = new_customer
    begin
      c.birthdate = Time.now
    rescue Exception => e
      assert_equal c.msg_invalid_class(:birthdate, String), e.message
    end
  end

  def test_should_throw_exception_invalid_date_format
    c = new_customer
    begin
      c.birthdate = "10/10/2014"
    rescue Exception => e
      assert_equal "Invalid date format, expected YYYY-MM-DD", e.message
    end
  end

  def test_should_throw_return_birthdate_equal_2014_06_10
    c = new_customer
    c.birthdate = birthdate = "2014-06-10"
    assert_equal birthdate, c.birthdate
  end

  private
  def new_customer
    KCielo::Request::Default::Customer.new
  end
end
