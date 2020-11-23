require 'test/helpers/test_helper'
require 'test/fake_object/response/fake_response'

class ResponseTest < Test::Unit::TestCase
  include TestHelper

  REQUEST_ID = FakeResponse.REQUEST_ID
  ERROR_PREFIX = "[HTTP-ERROR]"

  def test_should_convert_default_hash_to_response_object
    fake = fake_response.default_hash
    response = response_class.new(fake)

    each_expected_and_returned(fake, response) do |expected, returned|
      assert_equal(expected, returned)
    end
    assert_equal true, response.transaction_created?
  end

  def test_parse_with_nil_response_body
    fake = fake_response.build_error(:code => 404,:message => "Not Found", :body => nil)
    res = response_class.build_response(fake)

    assert_equal REQUEST_ID, res.request_id
    assert_equal "#{ERROR_PREFIX} 404 - Not Found", res.messages.first
  end


  def test_parse_with_cielo_error_response_body
    code = 128
    message = "Card Number length exceeded"
    body = "[{ \"Code\": #{code}, \"Message\": \"#{message}\"}]"

    fake = fake_response.build_error(:body => body)
    res = response_class.build_response(fake)

    assert_equal REQUEST_ID, res.request_id
    assert_equal KCielo::Pagador::ERROR_MESSAGE[code], res.messages.first
    assert_equal false, res.transaction_created?
  end

  private
  def response_class
    KCielo::Response::Default::Response
  end

  def fake_response
    FakeResponse.new
  end
end
