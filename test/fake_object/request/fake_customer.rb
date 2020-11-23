require 'test/fake_object/request/fake_address'

class FakeCustomer

  def self.default!(customer)
    customer.name = "José da Silva"
    customer.identity = "1234567890"
    customer.identity_type = "CPF"
    customer.email = "teste@teste.com.br"
    customer.birthdate = "1900-10-10"
    FakeAddress.default!(customer.address)
    FakeAddress.default_delivery!(customer.delivery_address)
    customer
  end

  def self.default_name!(customer)
    customer.name = "José da Silva"
    customer
  end
end
