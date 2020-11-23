require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_simplified_credit_card'

require 'test/fake_object/response/fake_response'

class SimplifiedCreditCardTest < Test::Unit::TestCase
  include TestHelper

  IGNORED_CLASS = [
                    KCielo::Response::PaymentWithCreditCard,
                    KCielo::Response::Default::Customer
                  ]

  def test_should_convert_default_hash_to_simplified_credit_card_object
    each_expected_and_returned(fake_hash, fake_object) do |expected, returned|
      assert_equal(expected, returned) if verify_class?(returned)
    end
  end

  def test_should_return_correct_payment_with_credit_card_class
    pwcc = fake_object.payment
    assert_equal(IGNORED_CLASS[0], pwcc.class)
  end

  def test_should_return_correct_customer_class
    c = fake_object.customer
    assert_equal(IGNORED_CLASS[1], c.class)
  end

  def test_parse_success_cielo_response_body
    body = "{
    \"MerchantOrderId\": \"2014111706\",
    \"Customer\": {
        \"Name\": \"Comprador Teste\"
    },
    \"Payment\": {
        \"ServiceTaxAmount\": 0,
        \"Installments\": 1,
        \"Interest\": \"ByMerchant\",
        \"Capture\": true,
        \"Authenticate\": false,
        \"CreditCard\": {
            \"CardNumber\": \"123412******1231\",
            \"Holder\": \"Teste Holder\",
            \"ExpirationDate\": \"12/2021\",
            \"SaveCard\": false,
            \"Brand\": \"Visa\"
        },
        \"ProofOfSale\": \"674532\",
        \"AuthorizationCode\": \"123456\",
        \"PaymentId\": \"24bc8366-fc31-4d6c-8555-17049a836a07\",
        \"Type\": \"CreditCard\",
        \"Amount\": 15700,
        \"Currency\": \"BRL\",
        \"Country\": \"BRA\",
        \"Provider\": \"Simulado\",
        \"ExtraDataCollection\": [],
        \"ReasonCode\": 0,
        \"ReasonMessage\": \"Successful\",
        \"Status\": 1,
        \"ProviderReturnCode\": \"4\",
        \"ProviderReturnMessage\": \"Operation Successful\",
        \"Links\": [
            {
                \"Method\": \"GET\",
                \"Rel\": \"self\",
                \"Href\": \"https://apiquerysandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}\"
            },
            {
                \"Method\": \"PUT\",
                \"Rel\": \"capture\",
                \"Href\": \"https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/capture\"
            },
            {
                \"Method\": \"PUT\",
                \"Rel\": \"void\",
                \"Href\": \"https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/void\"
            }
        ]
    }
}"

    fake = FakeResponse.new.build_success(:body => body)

    res = scc_class.build_response(fake)

    assert_equal reason_message[res.payment.reason_code], res.messages.first
    assert_equal 3, res.messages.size
    assert_equal "4", res.payment.provider_return_code
    assert_equal Array, res.payment.links.class
    assert_equal true, res.payment.links.first.respond_to?(:rel)
    assert_equal "24bc8366-fc31-4d6c-8555-17049a836a07", res.payment.payment_id
    assert_equal false, res.paid?
    assert_equal true, res.success?
  end

  private
  def verify_class?(returned)
    !IGNORED_CLASS.include? returned.class
  end

  def fake_hash
    FakeSimplifiedCreditCard.new.default_hash
  end

  def fake_object
    KCielo::Response::SimplifiedCreditCard.new(fake_hash)
  end

  def scc_class
    KCielo::Response::SimplifiedCreditCard
  end

  def reason_message
    KCielo::Pagador::REASON_MESSAGE
  end
end
