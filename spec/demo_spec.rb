require 'spec_helper'

describe "demo page" do
  
  before(:all) do
    webdriver.navigate.to(fixture_url("demo.html"))
  end
  
  describe "h1" do
  
    let(:h1) { webdriver.find_element(:css, 'h1') }
    subject { h1 }
  
    it { should have_color("#000000") }

    describe "text" do
      subject { h1.text }
      it { should == "Test page" }
    end

  end

  let(:main) { webdriver.find_element(:css, '#main') }
  let(:sidebar) { webdriver.find_element(:css, 'aside') }

  describe "#main" do

    it "is on the left of the window" do
      main.location.x.should <= 30
    end
    
  end

  # describe "sidebar" do
  #   
  #   it { should be_right_of("#main") }
  #   
  # end
  
end
