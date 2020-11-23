module KCielo
  module Response
    module Default
      class Link
        attr_reader :method, :rel, :href

        def initialize(h)
          @method = h["Method"]
             @rel = h["Rel"]
           @href = h["Href"]
        end

        def self.build_array(array)
          ary = []
          array.each do |link|
            ary << new(link)
          end
          ary
        end
      end
    end
  end
end
