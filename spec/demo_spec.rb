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

  describe "sidebar links" do

    subject { find_elements("aside li") }

    all { should be_left_aligned }

  end

  describe "sidebar" do

    subject { find_element("aside") }

    it { should be_right_of("#main") }

  end

  describe "article" do

    subject { find_element("article") }

    it { should be_enclosing("aside") }

  end

  describe "nav items" do

    subject { find_elements("#main nav li") }

    all { should be_top_aligned }
    all { should be_bottom_aligned }

  end

  describe "#a" do

    subject { find_element("#a") }

    it { should be_overlapping_with("#b") }
    it { should be_same_location_as("#c") }
    it { should be_overlaying("#c") }
    it { should be_same_height_as("#c") }
    it { should be_same_width_as("#c") }
    it { should be_same_size_as("#c") }
    it { should be_left_aligned_with("#c") }
    it { should be_right_aligned_with("#c") }

  end

  describe "overlap elements" do

    subject { find_elements("#a, #b") }

    all { should be_same_height }
    all { should be_same_width }
    all { should be_same_size }
    all { should be_left_aligned }
    all { should be_right_aligned }

  end

end
