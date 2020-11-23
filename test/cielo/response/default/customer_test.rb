require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_customer'
require 'cielo/response/default/customer'

class CustomerTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [KCielo::Response::Default::Address]

  def test_should_convert_default_hash_to_customer_object
    fake = FakeCustomer.new.default_hash
    customer = KCielo::Response::Default::Customer.new(fake)

    each_expected_and_returned(fake, customer) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end
end
