require 'test/fake_object/request/fake_customer'
require 'test/fake_object/request/fake_credit_card'

class FakeSimplifiedCreditCard
  def self.default!(scc)
    scc.merchant_order_id = '2014111703'
    FakeCustomer.default_name!(scc.customer)
    FakeCreditCard.default!(scc.payment.credit_card)
    scc.payment.amount = 15700
    scc.payment.provider = :simulado
    scc.payment.installments = 1
    scc
  end
end
