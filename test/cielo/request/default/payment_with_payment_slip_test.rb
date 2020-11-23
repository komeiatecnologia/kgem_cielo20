require 'test/helpers/test_helper'

class PaymentWithPaymentSlipTest < Test::Unit::TestCase

  def test_should_not_exists_instance_variable_installments
    pwps = new_pwps

    assert_equal(false, pwps.instance_variables.include?("@installments"))
  end

  private
  def new_pwps
    KCielo::Request::Default::PaymentWithPaymentSlip.new
  end
end
