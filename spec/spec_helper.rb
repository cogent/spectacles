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

RSpec::Matchers.define :be_colored do |hex_color|

  match do |element|
    @actual_color = element.style("color")
    @actual_color == hex_color
  end
  
  failure_message_for_should do |actual|
    "expected element be colored #{hex_color}, but it was #{@actual_color}"
  end

end

RSpec::Matchers.define :have_position do |expected_coordinates|

  match do |element|
    location = element.location
    @actual_coordinates = expected_coordinates.inject({}) do |h,(k,v)|
      h[k] = location.send(k)
      h
    end
    @actual_coordinates == expected_coordinates
  end

  failure_message_for_should do |actual|
    "expected element be at #{expected_coordinates}, but it was at #{@actual_coordinates}"
  end

end

class Selenium::WebDriver::Element

  def colored?(expected_color)
    style("color") == expected_color
  end
  
  def right_of?(other_element)
    other_rhs = other_element.location.x + other_element.size.width
    location.x > other_rhs
  end
  
end
