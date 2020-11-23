class FakeCreditCard
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    {
      "CardNumber" => "123412******1231",
      "Holder" => "Teste Holder",
      "ExpirationDate" => "12/2021",
      "SaveCard" => false,
      "Brand" => "Visa"
    }
  end
end
