require "spec_helper"

describe "demo page" do

  before(:all) do
    navigate_to(fixture_url("demo.html"))
  end

  describe "heading" do

    subject { find_element("h1") }

    its(:color) { should == "#cccccc" }
    its(:text) { should == "Test page" }

  end

  describe "main content" do

    subject { find_element("#main") }

    its("location.x") { should <= 30 }

  end

  describe "sidebar links" do

    subject { find_elements("aside li") }

    they { should be_left_aligned }

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

    they { should be_top_aligned }
    they { should be_bottom_aligned }

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
    it { should be_horizontally_aligned_with("#c") }
    it { should be_centred_with("#c") }

  end

  describe "overlapping elements" do

    subject { find_elements("#a, #b") }

    they { should be_same_height }
    they { should be_same_width }
    they { should be_same_size }
    they { should be_left_aligned }
    they { should be_right_aligned }
    they { should be_vertically_aligned }
    they { should_not be_horizontally_aligned }

  end

  describe "inline elements" do

    subject { find_elements("#inline > *") }

    they { should be_horizontally_aligned }
    they { should_not be_vertically_aligned }
    they { should be_top_aligned }
    they { should be_bottom_aligned }
    they { should be_same_height }

  end

end
