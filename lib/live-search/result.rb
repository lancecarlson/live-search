module LiveAPI
  module Search
    class Result
      def initialize(hash)
        @hash = hash
      end
      
      def method_missing(name)
        @hash[camelize(name)]
      end
      
      private
      
      # Ganked from rails
      def camelize(lower_case_and_underscored_word, first_letter_in_uppercase = true)
        if first_letter_in_uppercase
          lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
        else
          lower_case_and_underscored_word.first + camelize(lower_case_and_underscored_word)[1..-1]
        end
      end
    end
  end
end