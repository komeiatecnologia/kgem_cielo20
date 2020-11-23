class FakeDebitCard
  def self.default!(dc)
    dc.card_number = "0000000000000006"
    dc.holder = "J Silva"
    dc.expiration_date = "12/2021"
    dc.security_code = "123"
    dc.brand = :visa
    dc
  end
end
