require File.join(File.dirname(__FILE__), "spec_helper")

describe LiveAPI::Search do
  before do
    @search_term = "search engine optimization"
    LiveAPI.application_id = "" # Your app id here
  end
  
  it "should return the top 50 results for the term seo" do
    search = LiveAPI::Search.web(@search_term)
    results = search.results
    results.length.should == 50
  end
  
  it "should return the next 50 results for the search term seo" do
    search = LiveAPI::Search.web(@search_term, :Offset => 51)
    results = search.results
    results.length.should == 50
  end
end