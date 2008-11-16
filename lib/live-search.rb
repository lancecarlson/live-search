require "open-uri"
require "json"

module LiveAPI
  class << self
    attr_accessor :application_id
  end
  
  module Search
    class << self
      def web(query, options = {})
        options[:Query] = clean_query(query) unless query.nil?
        Request.new(options)
      end
      
      private
      
      def clean_query(query)
        query.gsub(" ", "+")
      end
    end
  end
end

%w(request response result version).each do |file|
  require File.join(File.dirname(__FILE__), "live-search", file)
end