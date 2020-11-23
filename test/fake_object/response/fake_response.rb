class FakeResponse

  REQUEST_ID = "12345678-1234-1234-1234-123456789012"

  def self.REQUEST_ID
    REQUEST_ID
  end

  def default_hash
    @@default_hash ||= {
                        "MerchantOrderId" => "2014111703",
                        "RequestId" => REQUEST_ID
                       }
  end

  def build_error(args = {})
    fake = new_fake
    args.each do |k, v|
      create_get_method fake, k, v
    end
    create_get_method fake, 'transaction_created', false
    fake
  end

  def build_success(args = {})
    fake = new_fake
    args.each do |k,v|
      create_get_method fake, k, v
    end

    def fake.kind_of?(clazz)
      true
    end
    fake
  end

  private
  def create_get_method(obj, method_name, value)
    var_name = "@#{method_name}"
    obj.instance_exec do
      instance_variable_set var_name.to_sym, value
      singleton = class << self; self end
      singleton.send :define_method, method_name, lambda { eval(var_name) }
    end
  end

  def new_fake
    fake = {}
    fake['RequestId'] = REQUEST_ID
    fake
  end
end
