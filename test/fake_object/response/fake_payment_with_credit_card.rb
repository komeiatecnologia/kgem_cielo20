require 'test/fake_object/response/fake_payment'
require 'test/fake_object/response/fake_link'
require 'test/fake_object/response/fake_credit_card'

class FakePaymentWithCreditCard
  def default_hash
    @@default_hash ||= build_hash
  end

  private
  def build_hash
    hash = FakePayment.new.default_hash
    hash['Authenticate'] = false
    hash['Capture'] = false
    hash['CreditCard'] = FakeCreditCard.new.default_hash
    hash['Installments'] = 1
    hash['Interest'] = "ByMerchant"
    hash['Links'] = FakeLink.default_hash_array
    hash['PaymentId'] = "24bc8366-fc31-4d6c-8555-17049a836a07"
    hash['ReasonCode'] = 0
    hash['ReasonMessage'] = "Successful"
    hash['ServiceTaxAmount'] = 0
    hash["AuthorizationCode"]= "923923"
    hash["ReceivedDate"] = "2015-07-15 09:16:40"
    hash["CapturedAmount"] = 15700
    hash["CapturedDate"] = "2015-07-15 09:16:40"
    hash["VoidedAmount"] = 15700
    hash["VoidedDate"] = "2015-07-15 11:52:20"
    hash['Type'] = "CreditCard"
    hash
  end
end
