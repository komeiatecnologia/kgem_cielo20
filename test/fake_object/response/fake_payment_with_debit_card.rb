require 'test/fake_object/response/fake_payment'
require 'test/fake_object/response/fake_link'
require 'test/fake_object/response/fake_debit_card'

class FakePaymentWithDebitCard
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    hash = FakePayment.new.default_hash
    hash['AuthenticationUrl'] = "https://xxxxxxxxxxxx.xxxxx.xxx.xx/xxx/xxxxx.xxxx?{PaymentId}"
    hash['DebitCard'] = FakeDebitCard.new.default_hash
    hash['Links'] = FakeLink.default_hash_array
    hash['PaymentId'] = "0309f44f-fe5a-4de1-ba39-984f456130bd"
    hash['ReasonCode'] = 9
    hash['ReasonMessage'] = "Waiting"
    # hash["AuthorizationCode"]= "923923"
    hash["ReceivedDate"] = "2015-03-25 09:36:20"
    hash['Type'] = "DebitCard"
    hash['ProviderReturnCode'] = "0"
    # hash['ProviderReturnMessage'] = "Operation Successful"
    hash
  end
end
