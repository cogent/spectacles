require 'spec_helper'

describe "position of h1" do
  
  it "is accessible" do
    webdriver.navigate.to(fixture_url("demo.html"))
    h1 = webdriver.find_element(:css, 'h1')
    h1.text.should == "Test page"
    h1.style("color").should == "#000000"
  end
  
end
