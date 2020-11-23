class FakePaymentWithPaymentSlip
  def self.default!(pwps)
    pwps.amount = 100
    pwps.provider = :simulado
  end
end
