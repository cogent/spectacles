require "spec_helper"

describe "demo page" do

  before(:all) do
    webdriver.navigate.to(fixture_url("demo.html"))
  end

  describe "h1" do

    let(:h1) { webdriver.find_element(:css, "h1") }
    subject { h1 }

    its(:color) { should == "#cccccc" }
    its(:text) { should == "Test page" }

  end

  describe "#main" do

    subject { webdriver.find_element(:css, "#main") }

    its(:x_position) { should <= 30 }

  end

  describe "aside" do

    subject { webdriver.find_element(:css, "aside") }

    it { should be_right_of("#main") }

  end

end
