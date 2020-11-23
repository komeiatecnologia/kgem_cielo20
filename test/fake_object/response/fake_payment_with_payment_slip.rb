require 'test/fake_object/response/fake_payment'
require 'test/fake_object/response/fake_link'
class FakePaymentWithPaymentSlip
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    h = FakePayment.new.default_hash
    h['Instructions'] = "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."
    h['ExpirationDate'] = "2015-01-05"
    h['Url'] = "https://apisandbox.cieloecommerce.cielo.com.br/pagador/reenvia.asp/8464a692-b4bd-41e7-8003-1611a2b8ef2d"
    h['Number'] = "123-2"
    h['BarCodeNumber'] = "00096629900000157000494250000000012300656560"
    h['DigitableLine'] = "00090.49420 50000.000013 23006.565602 6 62990000015700"
    h['Assignor'] = "Empresa Teste"
    h['Address'] = "Rua Teste"
    h['Identification'] = "11884926754"
    h['PaymentId'] = "a5f3181d-c2e2-4df9-a5b4-d8f6edf6bd51"
    h['ReasonCode'] = 0
    h['ReasonMessage'] = "Successful"
    h['Links'] = [FakeLink.default_hash]
    h
  end
end
