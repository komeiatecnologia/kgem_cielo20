require 'test/helpers/test_helper'

class AddressTest < Test::Unit::TestCase

  STR_256="Lorem ipsum dolor sit amet, consectetur adipiscing elit. In accumsan tellus nec elit elementum, sit amet aliquet orci eleifend. Aliquam non rutrum ipsum. In sed luctus leo. Sed sit amet sollicitudin tellus. Aenean sodales purus eget tortor ultrices nullam."
  STR_16="Lorem ipsum dolor sit amet."
  STR_51="Lorem ipsum dolor sit amet, consectetur massa nunc."
  STR_10="Lorem ipsu"

  def test_should_throw_exception_street_invalid_class_type
    a = new_address
    begin
      street = :rua_test
      a.street = street
    rescue Exception => e
      assert_equal a.msg_invalid_class(:street, String), e.message
    end
  end

  def test_should_throw_expection_street_greater_than_255_characters
    a = new_address
    begin
      a.street = STR_256
    rescue Exception => e
      assert_equal(msg_string_size(:street, 255), e.message)
    end
  end

  def test_should_return_street_equal_Rua_1
    a = new_address
    a.street = street = "Rua 1"
    assert_equal(street, a.street)
  end

  def test_should_throw_exception_if_number_not_is_string
    a = new_address
    begin
      a.number = 123
    rescue Exception => e
      assert_equal a.msg_invalid_class(:number, String), e.message
    end
  end

  def test_should_throw_expection_number_greater_than_9_characters
    a = new_address
    begin
      a.number = STR_16
    rescue Exception => e
      assert_equal msg_string_size(:number, 15), e.message
    end
  end

  def test_should_return_number_equal_123
    a = new_address
    a.number = number = '123'
    assert_equal number, a.number
  end

  def test_should_throw_exeception_if_complement_not_is_string
    a = new_address
    begin
      a.complement = :teste
    rescue Exception => e
      assert_equal a.msg_invalid_class(:complement, String), e.message
    end
  end

  def test_should_throw_expection_complement_greater_than_50_characters
    a = new_address
    begin
      a.complement = STR_51
    rescue Exception => e
      assert_equal msg_string_size(:complement, 50), e.message
    end
  end

  def test_should_returno_complement_equal_Complemento_1
    a = new_address
    a.complement = complement = "Complemento 1"
    assert_equal complement, a.complement
  end

  def test_should_throw_exception_if_zip_code_not_is_string
    a = new_address
    begin
      a.zip_code = 12345789
    rescue Exception => e
      assert_equal a.msg_invalid_class(:zip_code, String), e.message
    end
  end

  def test_should_throw_expection_zip_code_greater_than_9_characters
    a = new_address
    begin
      a.zip_code = STR_10
    rescue Exception => e
      assert_equal msg_string_size(:zip_code, 9), e.message
    end
  end

  def test_should_return_zip_code_equal_12345_000
    a = new_address
    a.zip_code = zip_code = '12345-000'
    assert_equal zip_code, a.zip_code
  end

  def test_should_throw_exception_if_city_not_id_string
    a = new_address
    begin
      a.city = :londrina
    rescue Exception => e
      assert_equal a.msg_invalid_class(:city, String), e.message
    end
  end

  def test_should_throw_expection_city_greater_than_50_characters
    a = new_address
    begin
      a.city = STR_51
    rescue Exception => e
      assert_equal msg_string_size(:city, 50), e.message
    end
  end

  def test_should_return_city_equal_Londrina
    a = new_address
    a.city = city = "Londrina"
    assert_equal a.city, city
  end

  def test_should_throw_exception_if_state_not_id_string
    a = new_address
    begin
      a.state = :SP
    rescue Exception => e
      assert_equal a.msg_invalid_class(:state, String), e.message
    end
  end

  def test_should_throw_exception_if_invalid_state_informed
    a = new_address
    begin
      a.state = "São Paulo"
    rescue Exception => e
      assert_equal address_class::INVALID_STATE, e.message
    end
  end

  def test_should_return_state_equal_SP
    a = new_address
    a.state = state ='SP'
    assert_equal state, a.state
  end

  def test_should_throw_exception_if_country_not_id_string
    a = new_address
    begin
      a.country = :BRA
    rescue Exception => e
      assert_equal a.msg_invalid_class(:country, String), e.message
    end
  end

  def test_should_throw_expection_country_greater_than_35_characters
    a = new_address
    begin
      a.country = STR_51
    rescue Exception => e
      assert_equal msg_string_size(:country, 35), e.message
    end
  end

  def test_should_return_country_equal_USA
    a = new_address
    a.country = country = 'USA'
    assert_equal country, a.country
  end

  private
  def new_address
    address_class.new
  end

  def address_class
    KCielo::Request::Default::Address
  end

  def msg_string_size(att, size)
    "#{att} longer than #{size} characters"
  end
end
