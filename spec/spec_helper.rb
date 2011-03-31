require 'rspec'
require "selenium-webdriver"
require 'pathname'

module WebDriverSupport

  EDGES = [:top, :right, :bottom, :left]

  def self.included(base)
    base.extend(ClassMethods)
  end

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

  module ClassMethods

    def all(*args, &block)
      it(*args, &block)
    end

  end

  module ElementGroup

    EDGES.each do |edge|
      define_method("#{edge}_aligned?") do
        same?(:"#{edge}_edge")
      end
    end

    [:width, :height, :size].each do |property|
      define_method(:"same_#{property}?") do
        same?(property)
      end
    end

    private

    def same?(property)
      map(&property).uniq.size == 1
    end

  end

  module Element

    def color
      style("color")
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

    def overlapping?(other_css_selector)
      other = other_element(other_css_selector)

      left_edge < other.right_edge &&
      right_edge > other.left_edge &&
      top_edge < other.bottom_edge &&
      bottom_edge > other.top_edge
    end

    [:width, :height, :size].each do |property|
      define_method(:"same_#{property}_as?") do |other_css_selector|
        send(property) == other_element(other_css_selector).send(property)
      end
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
