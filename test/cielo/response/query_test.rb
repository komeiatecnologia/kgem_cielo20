require 'test/helpers/test_helper'

class QueryTest < Test::Unit::TestCase

  QUERY = KCielo::Response::Query

  COMPLETE_PAYMENT_SLIP = KCielo::Response::CompletePaymentSlip

  SIMPLIFIED_CREDIT_CARD = KCielo::Response::SimplifiedCreditCard

  SIMPLIFIED_DEBIT_CARD = KCielo::Response::SimplifiedDebitCard

  ERRORS = KCielo::Response::Default::Errors

  def test_should_return_complete_payment_slip_response_object

    # response = fake_response
    #
    # response.body = '{"MerchantOrderId":"99910765","Customer":{"Name":"W A DE QUEIROZ-ME","Identity":"19873268000166","Address":{"Street":"Praça Santos Dumont","Number":"3961","ZipCode":"87501260","City":"Umuarama","State":"PR","Country":"BRA"}},"Payment":{"Instructions":"Não receber após o vencimento e não receber em cheque.","ExpirationDate":"2016-03-21","Demostrative":"","Url":"https://www.pagador.com.br/post/pagador/reenvia.asp/29fa4feb-58b2-4774-832a-5da6f242af4a","BoletoNumber":"24000000000010765-8","BarCodeNumber":"10498674000001165004519973000200040000107651","DigitableLine":"10494.51998 73000.200045 00001.076512 8 67400000116500","Assignor":"Fortunyt Sist. Avançado de Dist","Address":"Rua Pará, 1.500","Identification":"16.934.368/0001-67","PaymentId":"29fa4feb-58b2-4774-832a-5da6f242af4a","Type":"Boleto","Amount":116500,"ReceivedDate":"2016-03-18 08:41:58","Currency":"BRL","Country":"BRA","Provider":"Caixa","ReasonCode":0,"Status":1,"Links":[{"Method":"GET","Rel":"self","Href":"https://apiquery.braspag.com.br/v2/sales/29fa4feb-58b2-4774-832a-5da6f242af4a"}]}}'
    #
    # assert_equal QUERY.build_response(response).class, COMPLETE_PAYMENT_SLIP

  end

  def test_should_return_simplified_credit_card_response_object

    # response = fake_response
    #
    # response.body = '{"MerchantOrderId":"99910891","Customer":{"Name":"ADMIN ECBP","Address":{"Country":"BRA"},"DeliveryAddress":{"Country":"BRA"}},"Payment":{"ServiceTaxAmount":0,"Installments":2,"Interest":"ByMerchant","Capture":true,"Authenticate":false,"Recurrent":false,"CreditCard":{"CardNumber":"548984******1093","Holder":"Mauri Medeiros","ExpirationDate":"06/2023","SaveCard":false,"Brand":"Master"},"ProofOfSale":"009539","AcquirerTransactionId":"1047496809000002543A","AuthorizationCode":"035217","Eci":"0","PaymentId":"a656a0dd-e80b-40a2-92fc-ee2c100f417c","Type":"CreditCard","Amount":50880,"ReceivedDate":"2016-03-22 11:33:06","CapturedAmount":50880,"CapturedDate":"2016-03-22 11:33:07","Currency":"BRL","Country":"BRA","Provider":"Cielo","ReasonCode":0,"ReasonMessage":"Successful","Status":2,"ProviderReturnCode":"6","ProviderReturnMessage":"Transacao capturada com sucesso","Links":[{"Method":"GET","Rel":"self","Href":"https://apiquery.braspag.com.br/v2/sales/a656a0dd-e80b-40a2-92fc-ee2c100f417c"},{"Method":"PUT","Rel":"void","Href":"https://api.braspag.com.br/v2/sales/a656a0dd-e80b-40a2-92fc-ee2c100f417c/void"}]}}'
    #
    # assert_equal QUERY.build_response(response).class, SIMPLIFIED_CREDIT_CARD

  end

  def test_should_return_simplified_dedit_card_response_object

    # response = fake_response
    #
    # response.body = '{ "MerchantOrderId": "2014111703", "Customer": { "Name": "José da Silva", "Address": { "Country": "BRA" }, "DeliveryAddress": { "Country": "BRA" } }, "Payment": { "DebitCard": { "CardNumber": "000000******0006", "Holder": "J Silva", "ExpirationDate": "12/2021", "SaveCard": false, "Brand": "Visa" }, "AuthenticationUrl": "https://ecommerce.cielo.com.br/web/index.cbmp?id=0cc5525b13b1de759e50a4f0faa3e589", "AcquirerTransactionId": "1031068705000000210A", "PaymentId": "dacd5b26-5bb7-41f1-98c3-5de842472659", "Type":"DebitCard", "Amount": 15700, "ReceivedDate": "2015-11-24 14:04:08", "Currency": "BRL", "Country": "BRA", "Provider": "Cielo", "ReturnUrl": "https://subdominio.dominio.com/teste/123", "ReasonCode": 9, "ReasonMessage": "Waiting", "Status": 0, "ProviderReturnCode": "0", "Links": [ { "Method": "GET", "Rel": "self", "Href": "https://apiquery.braspag.com.br/v2/sales/dacd5b26-5bb7-41f1-98c3-5de842472659" } ] } }'
    #
    # assert_equal QUERY.build_response(response).class, SIMPLIFIED_DEBIT_CARD

  end

  def test_should_return_errors_response_object

    response = ""

    def response.body
      ''
    end

    def response.code
      500
    end

    def response.message
      ''
    end

    assert_equal QUERY.build_response(response).class, ERRORS

  end

  private
  def fake_response
    response = "Fake Response"

    def response.code
      201
    end

    def response.kind_of?(clazz)
      Net::HTTPSuccess == clazz
    end

    def response.body=(str_json)
      @body = str_json
    end

    def response.body
      @body
    end

    response
  end

end
