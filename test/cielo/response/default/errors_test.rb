require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_errors'

class ErrorsTest < Test::Unit::TestCase
  def test_should_return_success_equal_false
    e = new_errors(FakeErrors.array_with_one_error)
    assert_equal false, e.success?
  end

  def test_should_return_one_error
    e = new_errors(FakeErrors.array_with_one_error)
    assert_equal 1, e.messages.size
  end

  def test_should_return_two_errors
    e = new_errors(FakeErrors.array_with_two_errors)
    assert_equal 2, e.messages.size
  end

  def test_should_return_three_errors
    e = new_errors(FakeErrors.array_with_three_errors)
    assert_equal 3, e.messages.size
  end

  def test_should_return_valid_errors_message
    fake_array = FakeErrors.array_with_three_errors
    messages = new_errors(fake_array).messages
    messages.each_with_index do |error, index|
      assert_equal(error_message(fake_array,index), error)
    end
  end

  private
  def new_errors(array)
    KCielo::Response::Default::Errors.new(array)
  end

  def valid_error_class
    KCielo::Response::Default::Errors
  end

  def error_message(fake_array, index)
    "#{fake_array[index]['Code']} - #{fake_array[index]['Message']}"
  end
end
