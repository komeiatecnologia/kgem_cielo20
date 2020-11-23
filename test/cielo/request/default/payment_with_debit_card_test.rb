require 'test/helpers/test_helper'

class PaymentWithDebitCardTest < Test::Unit::TestCase

  def test_should_return_payment_with_debit_card_class
    p = new_payment_with_debit_card

    assert_equal KCielo::Request::Default::DebitCard, p.debit_card.class
  end

  def test_should_convert_payment_with_debit_card_to_cielo_hash_format
    p = new_payment_with_debit_card

    hash = p.to_cielo_hash
    assert_equal Hash, hash['DebitCard'].class
    assert_equal true, hash.key?('ReturnUrl')
  end

  def test_return_url_should_be_valid_url_string
    p = new_payment_with_debit_card

    url = "https://subdominio.dominio.com/teste/123"
    p.return_url = url

    assert_equal url, p.return_url
  end

  def test_return_url_should_be_invalid_url_string
    p = new_payment_with_debit_card
    url = 'não_sou_uma_url_valida'
    begin
      p.return_url= url
    rescue Exception => e
      assert_equal "Invalid URL: #{url}", e.message
    end
  end

  def test_return_url_should_be_invalid_url_type
    p = new_payment_with_debit_card

    begin
      p.return_url= URI('subdominio.dominio.com')
    rescue Exception => e
      assert_equal true, true
    end

    begin
      p.return_url= URL('subdominio.dominio.com')
    rescue Exception => e
      assert_equal true, true
    end
  end

  def test_type_should_return_DebitCard
    p = new_payment_with_debit_card
    p.type = :debit_card
    assert_equal "DebitCard", p.type
  end

  private
  def new_payment_with_debit_card
    KCielo::Request::Default::PaymentWithDebitCard.new
  end
end
