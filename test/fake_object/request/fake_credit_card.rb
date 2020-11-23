class FakeCreditCard
  def self.default!(cc)
    cc.card_number = "0000000000000006"
    cc.holder = "J Silva"
    cc.expiration_date = "12/2021"
    cc.security_code = "123"
    cc.brand = :visa
    cc
  end
end
