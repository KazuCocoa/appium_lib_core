require 'test_helper'

class AppiumLibCoreTest
  module Ios
    class DeviceTest < Minitest::Test
      def setup
        @core ||= ::Appium::Core.for(self, Caps::IOS_OPS)
        @driver ||= @core.start_driver
      end

      def test_hidekeyboard
        e = @core.wait { @driver.find_element :accessibility_id, 'TextFields' }
        e.click

        text = @core.wait { @driver.find_element :name, '<enter text>' }
        text.click

        assert @driver.find_element(:class, 'XCUIElementTypeKeyboard').displayed?

        @core.wait {
          @driver.hide_keyboard
          sleep 1 # wait animation
        }

        m = assert_raises Selenium::WebDriver::Error::NoSuchElementError do
          @driver.find_element(:class, 'XCUIElementTypeKeyboard')
        end
        assert 'An element could not be located on the page using the given search parameters.', m.message

        @driver.back
      end
    end
  end
end
