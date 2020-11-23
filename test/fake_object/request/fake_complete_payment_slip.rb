require 'test/fake_object/request/fake_customer'
require 'test/fake_object/request/fake_payment_with_payment_slip'

class FakeCompletePaymentSlip
  def self.default!(cps)
    FakeCustomer.default!(cps.customer)
    FakePaymentWithPaymentSlip.default!(cps.payment)
    cps.merchant_order_id = '2014111703'
    cps.payment.address = "Rua Teste"
    cps.payment.payment_slip_number = "123"
    cps.payment.assignor = "Empresa Teste"
    cps.payment.demonstrative = "Desmonstrative Teste"
    cps.payment.expiration_date = "2020-05-1"
    cps.payment.identification = '12345678901234'
    cps.payment.instructions = "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."
    cps
  end
end
