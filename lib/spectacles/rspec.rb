module Spectacles

  module RSpec

    def self.included(klass)
      klass.extend(ClassMethods)
    end

    module ClassMethods

      def all(*args, &block)
        it(*args, &block)
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

    private

    def webdriver
      @driver ||= Selenium::WebDriver.for(:firefox).tap do |driver|
        at_exit do
          driver.quit
        end
      end
    end

  end

end
