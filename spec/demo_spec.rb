require 'spec_helper'

describe "demo page" do
  
  before do
    webdriver.navigate.to(fixture_url("demo.html"))
  end
  
  describe "h1" do
  
    let(:h1) { webdriver.find_element(:css, 'h1') }
    subject { h1 }
  
    it { should have_color("#000800") }
    it { should have_position(:x => 5) }

    describe "text" do
      subject { h1.text }
      it { should == "Test page" }
    end

  end
  
end
