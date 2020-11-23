require 'test/fake_object/response/fake_address'
class FakeCustomer
  def default_hash
    @@default_hash ||= {
         "IdentityType" => "CPF",
            "Birthdate" => nil,
                "Email" => "teste@teste.com.br",
             "Identity" => "1234567890",
                 "Name" => "Jos\303\251 da Silva",
      "DeliveryAddress" => FakeAddress.new.default_hash,
              "Address" => FakeAddress.new.default_hash
    }
  end
end
