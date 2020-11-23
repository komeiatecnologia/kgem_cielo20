require 'test/helpers/test_helper'

class PaymentWithCompletePaymentSlipTest < Test::Unit::TestCase

  TARGET_METHODS = [
                  :address=, :assignor=, :demonstrative=, :expiration_date=,
                  :instructions=, :payment_slip_number=
                ]

  def test_should_not_exist_installment_variable_and_get_set_methods
    p = new_pwps
    assert_equal(false, p.instance_variables.include?("@installments"))
  end

  def test_type_should_return_Boleto
    p = new_pwps
    p.type = :payment_slip
    assert_equal "Boleto", p.type
  end

  def test_should_return_invalid_class_type_exception_message
    p = new_pwps
    TARGET_METHODS.each do |method|
      begin
        ad = :nao_sou_de_uma_string
        p.send(method, ad)
      rescue Exception => e
        at = method.to_s.gsub('=', '')
        assert_equal("#{at}: Invalid class type, expected String.class", e.message)
      end
    end
  end

  def test_should_return_cant_be_empty_exception_message
    p = new_pwps
    TARGET_METHODS.each do |method|
      begin
        ad = ""
        p.send(method, ad)
      rescue Exception => e
        assert_equal("#{method.to_s.gsub('=','')}: can't be empty", e.message)
      end
    end
  end

  def test_address_should_return_minha_rua_numero_10_centro_londrina
    p = new_pwps
    ad = "Rua: Minha Rua, número:12, Centro - Londrina/PR"
    p.address = ad
    assert_equal ad, p.address
  end

  def test_assignor_should_return_nome_da_empresa
    p = new_pwps
    ass  = "Nome da Empresa"
    p.assignor = ass
    assert_equal ass, p.assignor
  end

  def test_demonstrative_should_return_demonstrativo_da_empresa
    p = new_pwps
    dem = "Demonstrativo da Empresa"
    p.demonstrative = dem
    assert_equal dem, p.demonstrative
  end

  def test_expiration_date_should_return_invalid_date_format_exception_message
    p = new_pwps
    ed = "2017-10-11"
    begin
      p.expiration_date = ed
    rescue Exception => e
      assert_equal("#{ed}: invalid format date, expected YYYY-MM-DD", e.message)
    end
  end

  def test_expiration_date_should_return_invalid_date_exception_message
    p = new_pwps
    ed = "2016-02-30"
    begin
      p.expiration_date = ed
    rescue Exception => e
      assert_equal("invalid date", e.message)
    end
  end

  def test_expiration_date_should_return_2096_10_20
    p = new_pwps
    ed = "2096-10-20"
    p.expiration_date = ed
    assert_equal ed, p.expiration_date
  end

  def test_instructions_should_return_aceitar_somente_ate_a_data_de_vencimento_apos_essa_data_juros_de_1_porcento_dia
    p = new_pwps
    ins = "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."
    p.instructions = ins
    assert_equal ins, p.instructions
  end

  def test_payment_slip_number_should_return_12345
    p = new_pwps
    pn = "12345"
    p.payment_slip_number = pn
    assert_equal pn, p.payment_slip_number
  end

  def test_should_throw_if_identification_not_be_String
    pwps = new_pwps
    begin
      pwps.identification = 1234567
    rescue Exception => e
      assert_equal("identification: Invalid class type, expected String.class", e.message)
    end
  end

  def test_should_throw_if_identification_greater_than_14_digits
    pwps = new_pwps
    begin
      pwps.identification = '123456789012345'
    rescue Exception => e
      assert_equal("Invalid identity/identification, expected string with max 14 numeric characters(CPF/CPNJ)", e.message)
    end
  end

  def test_identification_should_return_1234567890
    pwps = new_pwps
    pwps.identification = '1234567890'
    assert_equal('1234567890', pwps.identification)
  end

  def test_cielo_hash_should_return_identification_equal_1234567890
    pwps = new_pwps
    pwps.identification = '1234567890'
    assert_equal('1234567890', pwps.to_cielo_hash['Identification'])
  end

  def test_should_cielo_hash_keys
    p = new_pwps
    hash = new_pwps.to_cielo_hash

    assert_equal(true, hash.key?('Type'))
    assert_equal(true, hash.key?('Amount'))
    assert_equal(true, hash.key?('Provider'))
    assert_equal(false, hash.key?('Installments'))

    assert_equal(true, hash.key?('Address'))
    assert_equal(true, hash.key?('BoletoNumber'))
    assert_equal(true, hash.key?('Assignor'))
    assert_equal(true, hash.key?('Demonstrative'))
    assert_equal(true, hash.key?('ExpirationDate'))
    assert_equal(true, hash.key?('Identification'))
    assert_equal(true, hash.key?('Instructions'))
  end

  private
  def new_pwps
    KCielo::Request::Default::PaymentWithCompletePaymentSlip.new
  end
end
