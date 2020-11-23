class FakeErrors
  def self.array_with_one_error
    [{'Code' => 1, 'Message' => 'Fake Error' }, "destinado ao request_id"]
  end

  def self.array_with_two_errors
    a = FakeErrors.array_with_one_error
    a.delete(a.last)
    a << {'Code' => 2, 'Message' => 'Fake Error'}
    a << "destinado ao request_id"
    a
  end

  def self.array_with_three_errors
    a = FakeErrors.array_with_two_errors
    a.delete(a.last)
    a << {'Code' => 3, 'Message' => 'Fake Error'}
    a << "destinado ao request_id"
    a
  end
end
