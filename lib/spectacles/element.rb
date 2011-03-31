module Spectacles

  module Element

    def color
      style("color")
    end

    def centre
      Selenium::WebDriver::Point.new(left_edge + (width / 2), top_edge + (height / 2))
    end

    def width
      size.width
    end

    def height
      size.height
    end

    def top_edge
      location.y
    end

    def right_edge
      left_edge + width
    end

    def bottom_edge
      top_edge + height
    end

    def left_edge
      location.x
    end

    def top_of?(other_css_selector)
      self.bottom_edge < other_element(other_css_selector).top_edge
    end

    def right_of?(other_css_selector)
      self.left_edge > other_element(other_css_selector).right_edge
    end

    def bottom_of?(other_css_selector)
      self.top_edge > other_element(other_css_selector).bottom_edge
    end

    def left_of?(other_css_selector)
      self.right_edge < other_element(other_css_selector).left_edge
    end

    def enclosing?(other_css_selector)
      other = other_element(other_css_selector)

      left_edge < other.left_edge &&
      right_edge > other.right_edge &&
      top_edge < other.top_edge &&
      bottom_edge > other.bottom_edge
    end

    def overlapping_with?(other_css_selector)
      other = other_element(other_css_selector)

      left_edge <= other.right_edge &&
      right_edge >= other.left_edge &&
      top_edge <= other.bottom_edge &&
      bottom_edge >= other.top_edge
    end

    def overlaying?(other_css_selector)
      other = other_element(other_css_selector)

      location == other.location &&
      size == other.size
    end

    [:location, :width, :height, :size].each do |property|
      define_method(:"same_#{property}_as?") do |other_css_selector|
        same_as?(property, other_css_selector)
      end
    end

    [:top, :right, :bottom, :left].each do |edge|
      define_method("#{edge}_aligned_with?") do |other_css_selector|
        same_as?(:"#{edge}_edge", other_css_selector)
      end
    end

    def vertically_aligned_with?(other_css_selector)
      other = other_element(other_css_selector)
      centre.x == other.centre.x
    end

    def horizontally_aligned_with?(other_css_selector)
      other = other_element(other_css_selector)
      centre.y == other.centre.y
    end

    def centred_with?(other_css_selector)
      other = other_element(other_css_selector)
      centre == other.centre
    end

    private

    def other_element(css_selector)
      return css_selector if css_selector.is_a?(Element)
      @bridge.findElementByCssSelector(nil, css_selector)
    end

    def same_as?(property, other_css_selector)
      send(property) == other_element(other_css_selector).send(property)
    end

  end

end

class Selenium::WebDriver::Element
  include Spectacles::Element
end
