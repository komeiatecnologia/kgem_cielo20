class FakeCancel
  def self.default_with_amount!(cancel)
    cancel = default_without_amount
    cancel.amount = 10
    cancel
  end

  def self.default_without_amount!(cancel)
    cancel.payment_id = "66893a06-8bb9-42c6-b836-d73c5420941f"
    cancel
  end
end
