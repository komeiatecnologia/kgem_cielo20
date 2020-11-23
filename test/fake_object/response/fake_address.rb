class FakeAddress
  def default_hash
    @@default_hash ||= {
            "City" => "Cidade  Entrega Padr\303\243o",
          "Street" => "Rua Padr\303\243o Entrega",
           "State" => "SC",
         "ZipCode" => "12345-000",
          "Number" => "456",
         "Country" => "Brasil",
      "Complement" => "Complemento padr\303\243o entrega"
    }
  end
end
