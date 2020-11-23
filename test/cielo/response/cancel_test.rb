require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_response'

class CancelTest
  def test_parse_with_cielo_success_response
    body = '{
    "Status": 10,
    "ReasonCode": 0,
    "ReasonMessage": "Successful",
    "ProviderReturnCode": "9",
    "ProviderReturnMessage": "Operation Successful",
    "Links": [
        {
            "Method": "GET",
            "Rel": "self",
            "Href": "https://apiquerysandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}"
        }
    ]
}'
    fake = FakeResponse.new.build_success(:body => body)
    res = KCielo::Response::Cancel.build_response(fake)
    assert_equal true, res.success?
    assert_equal 1, res.links.size
    assert_equal "self", res.links.first.rel
    assert_equal 2, res.messages.size
    assert_equal "Sucesso", res.messages.first
    assert_equal "9 - Operation Successful", res.messages.last
  end
end
