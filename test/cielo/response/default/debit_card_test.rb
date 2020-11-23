require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_debit_card'

class DebitCardTest < Test::Unit::TestCase
  include TestHelper

  def test_should_convert_default_hash_to_debit_card_object
    fake = FakeDebitCard.new.default_hash
    debit_card = KCielo::Response::Default::DebitCard.new(fake)

    each_expected_and_returned(fake, debit_card) do |expected, returned|
      assert_equal(expected, returned)
    end
  end
end
