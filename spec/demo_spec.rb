require "spec_helper"

describe "demo page" do

  before(:all) do
    navigate_to(fixture_url("demo.html"))
  end

  describe "h1" do

    subject { find_element("h1") }

    its(:color) { should == "#cccccc" }
    its(:text) { should == "Test page" }

  end

  describe "#main" do

    subject { find_element("#main") }

    its("location.x") { should <= 30 }

  end

  describe "aside" do

    subject { find_element("aside") }

    it { should be_right_of("#main") }

  end

  describe "article" do

    subject { find_element("article") }

    it { should be_enclosing("aside") }

  end

  describe "nav links" do

    subject { find_elements("#main nav li") }

    it { should be_aligned_to_top_edge }

    it { should be_aligned_to_bottom_edge }

  end

end
