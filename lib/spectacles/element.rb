module Spectacles

  module Element

    def color
      style("color")
    end

    def centre
      Selenium::WebDriver::Point.new(left + (width / 2), top + (height / 2))
    end

    def width
      size.width
    end

    def height
      size.height
    end

    def top
      location.y
    end

    def right
      left + width
    end

    def bottom
      top + height
    end

    def left
      location.x
    end

    def above?(css_selector)
      self.bottom < other_element(css_selector).top
    end

    def right_of?(css_selector)
      self.left > other_element(css_selector).right
    end

    def below?(css_selector)
      self.top > other_element(css_selector).bottom
    end

    def left_of?(css_selector)
      self.right < other_element(css_selector).left
    end

    def enclosing?(css_selector)
      other = other_element(css_selector)

      left < other.left &&
      right > other.right &&
      top < other.top &&
      bottom > other.bottom
    end

    def overlapping_with?(css_selector)
      other = other_element(css_selector)

      left <= other.right &&
      right >= other.left &&
      top <= other.bottom &&
      bottom >= other.top
    end

    def overlaying?(css_selector)
      other = other_element(css_selector)

      location == other.location &&
      size == other.size
    end

    [:centre, :location, :width, :height, :size].each do |property|
      define_method("same_#{property}_as?") do |css_selector|
        same?(property, css_selector)
      end
    end

    [:top, :right, :bottom, :left].each do |edge|
      define_method("#{edge}_aligned_with?") do |css_selector|
        same?(edge, css_selector)
      end
    end

    def vertically_aligned_with?(css_selector)
      other = other_element(css_selector)
      centre.x == other.centre.x
    end

    def horizontally_aligned_with?(css_selector)
      other = other_element(css_selector)
      centre.y == other.centre.y
    end

    def centred_with?(css_selector)
      other = other_element(css_selector)
      centre == other.centre
    end

    private

    def other_element(css_selector)
      return css_selector if css_selector.is_a?(Element)
      @bridge.findElementByCssSelector(nil, css_selector)
    end

    def same?(method_name, css_selector)
      send(method_name) == other_element(css_selector).send(method_name)
    end

  end

end

class Selenium::WebDriver::Element
  include Spectacles::Element
end
