module KCielo
  module Helpers

    LAST_DECIMAL_PLACE = /^.*\d+[\,|\.]\d{1}$/
    REGEX_VALID_PAYMENT = /^\w{8}-\w{4}-\w{4}-\w{4}-\w{12}$/
    VALID_IDENTIFICATION = /^\d{1,14}$/
    VALID_DATE_FORMAT = /\A\d{4}-\d{2}-\d{2}\z/
    VALID_URL = /\A(https|http)\:\/\/\w+(\.\w+)+.*\z/

    def valid_url_?(url)
      raise ArgumentError, "Invalid URL: #{url}", "#{self.class}" if url !~ VALID_URL
      true
    end

    def valid_class_type_?(attr_name, value, expected_class)
      raise TypeError, msg_invalid_class(attr_name, expected_class), "#{self.class}" if !value.kind_of? expected_class
      true
    end

    def parameter_exists_?(parameter, options)
      if options.kind_of? Array
        element_exists_in_array_?(parameter, options)
      else
        element_exists_in_hash_?(parameter, options)
      end
    end

    def array_to_sentece(array)
      sentence = nil
      array.each do |e|
        sentence.nil? ? sentence = "#{e}" : sentence << ", #{e}"
      end
      sentence
    end

    def hash_to_sentence(hash)
      sentence = nil
      hash.each do |key, value|
        sentence.nil? ? sentence = "{:#{key} => '#{value}'" : sentence << ", :#{key} => '#{value}'}"
      end
      sentence
    end

    def greater_than_zero_?(number)
      raise ArgumentError, msg_less_or_equal_zero(number), "#{self.class}" if number <= 0
      true
    end

    def msg_less_or_equal_zero(value)
      "Value must be greater than zero: #{value}"
    end

    def present_?(value, attribute)
      empty_string = value.strip.empty? if value.kind_of? String
      raise ArgumentError, msg_can_not_be_empty(attribute), "#{self.class}" if value.nil? || empty_string
      true
    end

    def present?(value)
      empty_string = value.string.empty? if value.kind_of? String
      value.nil? ||empty_string
    end

    def valid_?
      instance_variables.each do |at|
        at.gsub!('@','')
        raise ArgumentError,
              "#{msg_can_not_be_empty(at)}",
              "#{self.class}" if verify?(at) && send(at).nil?
      end
      true
    end

    def msg_invalid_class(attr_name, expected_class)
      "#{attr_name}: Invalid class type, expected #{expected_class}.class"
    end

    def msg_can_not_be_empty(attribute)
      "#{attribute}: can't be empty"
    end

    def camelcase_to_snakecase(string)
      while !(string !~ /([a-z])([A-Z])/)
        string = string.gsub("#{$1}#{$2}", "#{$1}_#{$2}")
      end
      string.downcase
    end

    def snakecase_to_camelcase(string)
      while !(string !~ /([a-z])(_)([a-z])/)
        string = string.gsub("#{$1}#{$2}#{$3}", "#{$1}" + "#{$3}".upcase)
      end
      string
    end

    def snakecase_to_cielocase(string)
      snakecase_to_camelcase(string.capitalize)
    end

    def greater_than_current_date_?(year_month_day, format="%Y-%m-%d")
      raise ArgumentError, "#{year_month_day}: invalid format date, expected YYYY-MM-DD", "#{self.class}" if year_month_day !~ /(\d{4})-(\d{1,2})-(\d{1,2})/
      current = Time.now
      raise ArgumentError, "The date is less than current date" if Date.strptime("#{current.year}-#{current.month}-#{current.day}", format) > Date.strptime(year_month_day, format)
      true
    end

    def valid_string_size_?(value, attribute, size)
      raise ArgumentError, "#{attribute} longer than #{size} characters", "#{self.class}" if value.size > size
      true
    end

    # Money manipulation
    def standardize_amount(value)
      greater_than_zero_?(value.to_i)
      value = string_to_integer(value) if value.kind_of? String
      value = bigdecimal_to_integer(value) if value.kind_of? BigDecimal
      value = float_to_integer(value) if value.kind_of? Float
      value
    end

    def string_to_integer(value)
      value = insert_last_decimal_place(value)
      value.gsub(/\D/, '').to_i
    end

    def bigdecimal_to_integer(value)
      value = value.to_digits
      string_to_integer(value)
    end

    def float_to_integer(value)
      value = value.to_s
      string_to_integer(value)
    end

    def insert_last_decimal_place(value)
      value << '0' unless value !~ LAST_DECIMAL_PLACE
      value
    end

    def valid_payment_id_format?(payment_id)
      raise(ArgumentError,
            "Invalid payment_id, expected xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
            self.class.to_s) if payment_id !~ REGEX_VALID_PAYMENT
      true
    end

    def valid_string_date_format_?(string_date)
      raise(ArgumentError, "Invalid date format, expected YYYY-MM-DD"
        ) if string_date !~ VALID_DATE_FORMAT
      true
    end

  private
    def valid_identification_format?(identification)
      raise( ArgumentError,
            "Invalid identity/identification, expected string with max 14 numeric characters(CPF/CPNJ)",
            self.class.to_s) if identification !~ VALID_IDENTIFICATION
      true
    end

    def verify?(attribute)
      attribute = attribute.to_sym
      return !can_be_nil.include?(attribute) if can_be_nil
      return cannot_be_nil.include?(attribute) if cannot_be_nil
      true
    end

    def can_be_nil
      self.class.CAN_BE_NIL if self.class.respond_to? :CAN_BE_NIL
    end

    def cannot_be_nil
      self.class.CANNOT_BE_NIL if self.class.respond_to? :CANNOT_BE_NIL
    end

    def element_exists_in_hash_?(key, hash)
      raise ArgumentError,
            "Not exists #{key} in: #{hash_to_sentence(hash)}" unless hash.key? key
      true
    end

    def element_exists_in_array_?(element, array)
      raise ArgumentError, "Not exists #{element} in: #{array_to_sentece(array)}" unless array.include? element
      true
    end
  end
end
