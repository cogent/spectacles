require 'rspec'
require "selenium-webdriver"
require 'pathname'

module WebDriverSupport

  EDGES = [:top, :right, :bottom, :left]

  def webdriver
    @driver ||= Selenium::WebDriver.for(:firefox).tap do |driver|
      at_exit do
        driver.quit
      end
    end
  end

  def navigate_to(url)
    webdriver.navigate.to(url)
  end

  def find_element(css_selector)
    webdriver.find_element(:css, css_selector)
  end

  def find_elements(css_selector)
    webdriver.find_elements(:css, css_selector)
  end

  module ElementGroup

    EDGES.each do |edge|
      define_method("#{edge}_aligned?") do
        map(&:"#{edge}_edge").uniq.size == 1
      end
    end

  end

  module Element

    def color
      style("color")
    end
    def top_edge
      location.y
    end

    def right_edge
      left_edge + size.width
    end

    def bottom_edge
      top_edge + size.height
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

    private

    def other_element(css_selector)
      @bridge.findElementByCssSelector(nil, css_selector)
    end

  end

end

module Fixtures

  def fixture_path(name)
    Pathname(__FILE__).parent.parent + "fixtures" + name
  end

  def fixture_url(name)
    "file://#{fixture_path(name).realpath}"
  end

end

RSpec.configure do |config|

  config.include WebDriverSupport
  config.include Fixtures

end

class Selenium::WebDriver::Element

  include WebDriverSupport::Element

end

class Array

  # TODO: YUK!

  include WebDriverSupport::ElementGroup

end
