require 'rspec'
require "selenium-webdriver"
require 'pathname'

module WebDriverSupport

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

  # config.include Paperclip::Shoulda::Matchers
  #
  # config.mock_with :rr
  #
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"
  # config.use_transactional_fixtures = true

  config.include WebDriverSupport
  config.include Fixtures

end

class Selenium::WebDriver::Element

  class Rectangle < Struct.new(:location, :size)

    def right_of?(other)
      self.left_edge > other.right_edge
    end

    def left_edge
      location.x
    end

    def right_edge
      left_edge + size.width
    end

    def top_edge
      location.y
    end

    def bottom_edge
      top_edge + size.height
    end

  end

  def color
    style("color")
  end

  def right_of?(css_selector)
    other_element = @bridge.findElementByCssSelector(nil, css_selector)
    bounds.right_of?(other_element.bounds)
  end

  def bounds
    Rectangle.new(location, size)
  end

end
