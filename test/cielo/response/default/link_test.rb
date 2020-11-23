require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_link'
require 'lib/cielo/response/default/link'

class LinkTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_link_object
    fake = FakeLink.default_hash
    link = KCielo::Response::Default::Link.new(fake)

    each_expected_and_returned(fake, link) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
