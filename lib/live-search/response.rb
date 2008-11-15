module LiveAPI
  module Search
    class Response
      def initialize(response_body)
        @body = response_body
      end
      
      # The number of URLs returned. This may be lower than the number of results requested if there were fewer total results available.
      def total
        self.to_json["SearchResponse"]["Web"]["Total"].to_i
      end

      # The result objects returned from the request
      def results
        begin
          self.to_json["SearchResponse"]["Web"]["Results"].map do |result_hash|
            LiveAPI::Search::Result.new(result_hash)
          end
        rescue
          self.to_json["SearchResponse"]
        end
      end
      
      def to_json
        @json = @json ||= JSON.parse(@body)
      end
    end
  end
end