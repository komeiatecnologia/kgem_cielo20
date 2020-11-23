class FakePayment

  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
   {  "Type" => "CreditCard",
      'Amount' => "15700",
      "Country" => "BRA",
      "Currency" => "BRL",
      "Provider" => "Simulado",
      "Status" => 1,
      "ExtraDataCollection" => []
   }
  end
end

