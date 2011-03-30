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

