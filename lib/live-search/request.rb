module LiveAPI
  module Search
    class Request
      API_DOMAIN = "http://api.search.live.net/"
      FORMAT = "json"
      SOURCE = "web"
      DEFAULT_OFFSET = 0
      DEFAULT_COUNT = 50
      DEFAULT_MARKET = "en-US"
      
      # Converts a hash to a query string
      def self.hash_to_query(hash)
        hash.map {|key, value| "#{key}=#{value}"}.join("&")
      end
      
      def initialize(options)
        @options = options
        @options[:AppId] = LiveAPI.application_id
        @options[:Format] = FORMAT
        @options[:Sources] = SOURCE
        @options[:Count] = @options[:Count] ||= DEFAULT_COUNT
        @options[:Offset] = @options[:Offset] ||= DEFAULT_OFFSET
        @options[:Market] = @options[:Market] ||= DEFAULT_MARKET
        
        raise "Application ID is needed" if @options[:AppId].nil?
        raise "A query is needed" unless @options.has_key?(:Query)
      end
    
      # The API URL call
      def path
        @options["Web.Count"] = @options[:Count]
        @options["Web.Offset"] = @options[:Offset]
        @options.delete(:Count)
        @options.delete(:Offset)
        "#{API_DOMAIN}/#{@options[:Format]}.aspx?#{query_string}"
      end
      
      # The response object of the request
      def response
        @response = @response ||= LiveAPI::Search::Response.new(response_body)
      end
      
      # The response body of the request
      def response_body
        open(path).readlines.join
      end
      
      # The results from the response object
      def results
        response.results
      end
      
      def query_string  
        self.class.hash_to_query(@options)
      end
    end
  end
end