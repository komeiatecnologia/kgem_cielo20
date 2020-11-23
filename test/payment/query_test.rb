require 'test/helpers/test_helper'

class Query < Test::Unit::TestCase
  def test_should_throw_payment_id_can_not_be_empty
    q = new_query
    begin
      q.consult
    rescue Exception => e
      assert_equal q.msg_can_not_be_empty('payment_id'), e.message
    end
  end

  private
  def new_query
    KCielo::Payment::Query.new
  end
end
