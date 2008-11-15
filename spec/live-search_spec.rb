require File.join(File.dirname(__FILE__), "spec_helper")

describe LiveAPI::Search do
  it "should return the top 50 results for the term seo" do
    LiveAPI.application_id = "" # Your app id here
    search = LiveAPI::Search.web("seo")
    results = search.results
    results.length.should == 50
  end
end