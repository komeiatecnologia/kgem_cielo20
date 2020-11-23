require 'test/helpers/test_helper'
require 'test/fake_object/request/fake_cancel'

class PaymentCancelTest < Test::Unit::TestCase
  include KCielo::Helpers

  def test_should_throw_can_not_be_empty_when_payment_id_equal_nil
    cancel = fake_without_amount
    cancel.instance_variable_set :@payment_id, nil
    begin
      cancel.valid_?
    rescue Exception => e
      assert_equal cancel.msg_can_not_be_empty("payment_id"), e.message
    end
  end

  def test_should_throw_can_not_be_empty_when_try_cancel
    cancel = fake_without_amount
    cancel.instance_variable_set :@payment_id, nil
    begin
      cancel.cancel
    rescue Exception => e
      assert_equal cancel.msg_can_not_be_empty("payment_id"), e.message
    end
  end

  private
  def new_cancel
    KCielo::Payment::Cancel.new
  end

  def fake_without_amount
    cancel = new_cancel
    FakeCancel.default_without_amount! cancel
    cancel
  end
end
