require 'rubygems'
require 'net/http'
require 'net/https'
require 'openssl'
require 'securerandom'
require 'date'
require 'bigdecimal'
require 'bigdecimal/util'
require 'kgem_log'
require 'json'

require 'cielo/helpers/configuration'
require 'cielo/helpers/helpers_class'
require 'cielo/helpers/helpers'
require 'cielo/helpers/meta'

require 'cielo/pagador/pagador'

require 'cielo/request/default/address'
require 'cielo/request/default/request'
require 'cielo/request/default/payment'
require 'cielo/request/default/card'
require 'cielo/request/default/debit_card'
require 'cielo/request/default/credit_card'
require 'cielo/request/default/customer'
require 'cielo/request/default/payment_with_debit_card'
require 'cielo/request/default/payment_with_credit_card'
require 'cielo/request/default/payment_with_payment_slip'
require 'cielo/request/default/payment_with_complete_payment_slip'

require 'cielo/response/default/response'
require 'cielo/response/default/errors'
require 'cielo/response/default/link'
require 'cielo/response/default/payment'
require 'cielo/response/default/card'
require 'cielo/response/default/credit_card'
require 'cielo/response/default/debit_card'
require 'cielo/response/default/customer'
require 'cielo/response/default/address'
require 'cielo/response/default/payment_with_credit_card'
require 'cielo/response/default/payment_with_debit_card'
require 'cielo/response/default/payment_with_payment_slip'

require 'cielo/response/cancel'
require 'cielo/response/complete_payment_slip'
require 'cielo/response/simplified_credit_card'
require 'cielo/response/simplified_debit_card'
require 'cielo/response/query'

require 'cielo/request/cancel'
require 'cielo/request/complete_payment_slip'
require 'cielo/request/simplified_credit_card'
require 'cielo/request/simplified_debit_card'
require 'cielo/request/query'

require 'cielo/webservice/cancel'
require 'cielo/webservice/complete_payment_slip'
require 'cielo/webservice/rest_client'
require 'cielo/webservice/simplified_credit_card'
require 'cielo/webservice/simplified_debit_card'
require 'cielo/webservice/query'

require 'cielo/payment/cancel'
require 'cielo/payment/complete_payment_slip'
require 'cielo/payment/simplified_credit_card'
require 'cielo/payment/simplified_debit_card'
require 'cielo/payment/query'

module KCielo
  extend Configuration

  SimplifiedCreditCard = Payment::SimplifiedCreditCard
  SCC = SimplifiedCreditCard

  SimplifiedDebitCard = Payment::SimplifiedDebitCard
  SDC = SimplifiedDebitCard

  CompletePaymentSlip = Payment::CompletePaymentSlip
  CPS = CompletePaymentSlip

  Cancel = Payment::Cancel
  C = Cancel

  Query = Payment::Query
  Q = Query

  ## FILE PATH TO CA CERTIFICATE (*.pem)
  define_setting :ca_file_path, "#{File.dirname(__FILE__)}/cielo.pem"

  ## PAYMENT METHODS AVAILABLE
  define_setting :payment_types, {
                                  :credit_card => "CreditCard",
                                  :debit_card => "DebitCard",
                                  # :eletronic_transfer => "EletronicTransfer",
                                  :payment_slip => "Boleto"
                                 }

  ## CREDIT CARD BRANDS AVAILABLE
  define_setting :credit_card_brands, {
                                        :visa => 'Visa',
                                        :mastercard => 'Master',
                                        :amex => 'Amex',
                                        :elo => 'Elo',
                                        :aura => 'Aura',
                                        :jcb => 'JCB',
                                        :diners => 'Diners',
                                        :discover => 'Discover',
                                        :hipercard => 'Hipercard',
                                        :hiper => 'Hiper'
                                      }

  define_setting :debit_card_brands, {
                                        :visa => "Visa",
                                        :mastercard => "Master"
                                      }

  ## CREDIT CARD PROVIDERS AVAILABLE
  define_setting :credit_card_providers, {
                                           :simulado => "Simulado",
                                           :cielo => "Cielo",
                                           :rede => "Redecard"
                                         }

  ## DEBIT CARD PROVIDERS AVAILABLE
  define_setting :debit_card_providers, {
                                          :simulado => "Simulado",
                                          :cielo => "Cielo"
                                        }

  ## AVAILABLE OPTIONS FOR RESPONSIBLE FOR INSTALLMENT SALES MADE BY CREDIT CARD
  define_setting :responsible_for_installment, {
                                                  :merchant => "ByMerchant",
                                                  :issuer => "ByIssuer"
                                               }

  define_setting :payment_slip_providers, {
                                            :bradesco => "Bradesco2",
                                            :banco_do_brasil => "BancoDoBrasil2",
                                            :citibank => "CitiBank",
                                            :itau => "Itau",
                                            :brb => "Brb",
                                            :caixa => "Caixa",
                                            :santander => "Santander2",
                                            :hsbc => "HSBC",
                                            :simulado => "Simulado"
                                          }
  # define_setting :eletronic_transfer_providers, {
  #                                                 :bradesco => "Bradesco",
  #                                                 :simulado => "Simulado"
  #                                               }

  ##REQUEST SETTINGS
  define_setting :timeout, 20

  # Development merchant https://cadastrosandbox.cielo.com.br
  # define_setting :merchant_id, "d1f105a3-edbf-41e3-bc2e-49c93d2b4b96"
  # define_setting :merchant_key, "JOXEBQTVZGGWKQCOZAEGOXXWCUCYLKOVMPVMOLCB"

  define_setting :merchant_id, nil
  define_setting :merchant_key, nil

  define_setting :connection_attempts, 3

  #URLs
  # define_setting :payment_url, "https://apisandbox.cieloecommerce.cielo.com.br"
  # define_setting :query_url, "https://apiquerysandbox.cieloecommerce.cielo.com.br"

  # Production URLs
  define_setting :payment_url, "https://api.cieloecommerce.cielo.com.br"
  define_setting :query_url, "https://apiquery.cieloecommerce.cielo.com.br"

  ##RESOURCES
  define_setting :complete_payment_slip_resource, "/1/sales/"
  define_setting :simplified_credit_card_resource, "/1/sales/"
  define_setting :simplified_debit_card_resource, "/1/sales/"
  define_setting :cancel_resource, "/1/sales/"
  define_setting :query_resource, "/1/sales/"

  ## DEFAULT RESPONSIBLE INSTALLMENTS
  define_setting :interest, :issuer
end
