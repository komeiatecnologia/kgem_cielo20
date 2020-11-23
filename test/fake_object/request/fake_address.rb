class FakeAddress
  def self.default!(ad)
    ad.street = "Rua Padrão"
    ad.number = "123"
    ad.complement = "Complemento padrão"
    ad.zip_code = "12345-000"
    ad.city = "Cidade Padrão"
    ad.state = "SP"
    # ad.country = "Brasil"
  end

  def self.default_delivery!(ad)
    ad.street = "Rua Padrão Entrega"
    ad.number = "456"
    ad.complement = "Complemento padrão entrega"
    ad.zip_code = "12345-000"
    ad.city = "Cidade  Entrega Padrão"
    ad.state = "SC"
    ad.country = "Brasil"
  end
end
