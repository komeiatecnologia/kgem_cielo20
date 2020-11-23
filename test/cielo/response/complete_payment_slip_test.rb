require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_complete_payment_slip'
require 'test/fake_object/response/fake_response'

class CompletePaymentSlipTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [
                    KCielo::Response::Default::Customer,
                    KCielo::Response::Default::PaymentWithPaymentSlip
                  ]

  def test_should_convert_hash_to_complete_payment_slip_object
    each_expected_and_returned(fake_hash, fake_object) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_valid_customer_class
    c = fake_object.customer
    assert_equal(IGNORED_CLASS[0], c.class)
  end

  def test_should_return_valid_payment_with_payment_slip_class
    pwps = fake_object.payment
    assert_equal(IGNORED_CLASS[1], pwps.class)
  end

  def test_parse_with_cielo_success_response
    body = "{
    \"MerchantOrderId\": \"2014111706\",
    \"Customer\":
    {
        \"Name\": \"Comprador Teste\",
        \"Address\": {}
    },
    \"Payment\":
    {
        \"Instructions\": \"Aceitar somente até a data de vencimento, após essa data juros de 1% dia.\",
        \"ExpirationDate\": \"2015-01-05\",
        \"Url\": \"https://apisandbox.cieloecommerce.cielo.com.br/pagador/reenvia.asp/8464a692-b4bd-41e7-8003-1611a2b8ef2d\",
        \"Number\": \"123-2\",
        \"BarCodeNumber\": \"00096629900000157000494250000000012300656560\",
        \"DigitableLine\": \"00090.49420 50000.000013 23006.565602 6 62990000015700\",
        \"Assignor\": \"Empresa Teste\",
        \"Address\": \"Rua Teste\",
        \"Identification\": \"11884926754\",
        \"PaymentId\": \"a5f3181d-c2e2-4df9-a5b4-d8f6edf6bd51\",
        \"Type\": \"Boleto\",
        \"Amount\": 15700,
        \"Currency\": \"BRL\",
        \"Country\": \"BRA\",
        \"Provider\": \"Simulado\",
        \"ExtraDataCollection\": [],
        \"ReasonCode\": 0,
        \"ReasonMessage\": \"Successful\",
        \"Status\": 1,
        \"Links\": [
            {
                \"Method\": \"GET\",
                \"Rel\": \"self\",
                \"Href\": \"https://apiquerysandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}\"
            }
        ]
    }
}"
    fake = FakeResponse.new.build_success(:body => body)
    res = cps_class.build_response(fake)
    assert_equal reason_message[res.payment.reason_code], res.messages.first
    assert_equal "2015-01-05", res.payment.expiration_date
    assert_equal "Simulado", res.payment.provider
    assert_equal "Comprador Teste", res.customer.name
    assert_equal "2014111706", res.merchant_order_id
    assert_equal false, res.paid?
    assert_equal true, res.success?
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_hash
    FakeCompletePaymentSlip.new.default_hash
  end

  def fake_object
    KCielo::Response::CompletePaymentSlip.new(fake_hash)
  end

  def cps_class
    KCielo::Response::CompletePaymentSlip
  end

  def reason_message
    KCielo::Pagador::REASON_MESSAGE
  end
end
