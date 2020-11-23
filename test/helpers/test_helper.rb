require 'test/unit'
require 'lib/kgem_cielo'

module TestHelper
  include KCielo::Helpers

  def each_expected_and_returned(cielo_hash, object)
    object.instance_variables.each do |m|
      method = m.gsub('@','')
      value_expected = get_value_expected(cielo_hash, object, method)
      value_returned = object.send(method.to_sym)
      yield value_expected, value_returned
    end
  end

  private
  def get_value_expected(cielo_hash, object, method)
    return status_message(object.status) if method == 'status_message'
    cielo_hash[snakecase_to_cielocase(method)]
  end

  def status_message(key)
    KCielo::Pagador::STATUS[key]
  end
end
