module KCielo
  module Response
    module Default
      class Card
        attr_reader :brand, :card_number, :expiration_date, :holder, :save_card

        def initialize(hash)
          @brand = hash['Brand']
          @card_number = hash['CardNumber']
          @expiration_date = hash['ExpirationDate']
          @holder = hash['Holder']
          @save_card = hash['SaveCard']
        end
      end
    end
  end
end
