require 'lib/cielo/response/default/link'
class FakeLink
  def self.array_links
    a = []
    a << new_link({
          "Method" => "GET",
          "Rel" => "self",
          "Href" => "https://apiquerysandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}"
      })
    a << new_link({
          "Method" => "PUT",
          "Rel" => "capture",
          "Href" => "https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/capture"
      })
    a << new_link({
          "Method" => "PUT",
          "Rel" => "void",
          "Href" => "https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/void"
      })
  end

  def self.default_hash
    default_hash_array[Time.now.to_i % 3]
  end

  def self.default_hash_array
    [
      {
          "Method" => "GET",
          "Rel" => "self",
          "Href" => "https://apiquerysandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}"
      },
      {
          "Method" => "PUT",
          "Rel" => "capture",
          "Href" => "https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/capture"
      },
      {
          "Method" => "PUT",
          "Rel" => "void",
          "Href" => "https://apisandbox.cieloecommerce.cielo.com.br/1/sales/{PaymentId}/void"
      }
    ]
  end

  private
  def new_link(hash)
    KCielo::Response::Default::Link.new(hash)
  end
end
