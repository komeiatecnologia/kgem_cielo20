require 'test/fake_object/request/fake_customer'
require 'test/fake_object/request/fake_debit_card'

class FakeSimplifiedDebitCard
  def self.default!(sdc)
    sdc.merchant_order_id = '2014111703'
    FakeCustomer.default_name!(sdc.customer)
    FakeDebitCard.default!(sdc.payment.debit_card)
    sdc.payment.amount = 15700
    sdc.payment.provider = :cielo
    sdc.payment.return_url = 'https://subdominio.dominio.com/teste/123'
    sdc
  end
end
