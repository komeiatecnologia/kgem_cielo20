require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_address'
require 'cielo/response/default/address'

class AddressTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_address_object
    fake = FakeAddress.new.default_hash
    address = KCielo::Response::Default::Address.new(fake)

    each_expected_and_returned(fake, address) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
