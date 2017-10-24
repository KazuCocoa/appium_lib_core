require 'test_helper'

class AppiumLibCoreTest
  class PathTest < Minitest::Test

    def setup
      opts = {
          caps: {
              platformName: :ios,
              automationName: 'XCUITest',
              app: 'test/app/UICatalog.app',
              platformVersion: '10.3',
              deviceName: 'iPhone Simulator',
              some_capability: 'some_capability'
          },
          appium_lib: {
              export_session: true,
              wait: 30,
              wait_timeout: 20,
              wait_interval: 1
          }
      }
      @core ||= ::Appium::Core.for(self, opts)
      @driver ||= @core.start_driver
    end

    def test_value
      e = @core.wait { @driver.find_element :accessibility_id, 'Buttons' }

      assert_equal 'Buttons', e.value
    end

    def test_name
      e = @core.wait { @driver.find_element :accessibility_id, 'Buttons' }

      assert_equal 'Buttons', e.name
    end

    def test_label
      e = @core.wait { @driver.find_element :accessibility_id, 'Buttons' }

      assert_equal 'Buttons', e.label
    end

    def test_type
      e = @core.wait { @driver.find_element :accessibility_id, 'TextFields' }
      e.click

      text = @core.wait { @driver.find_element :name, '<enter text>' }
      text.type 'hello'

      text = @core.wait { @driver.find_element :name, 'Normal' }

      assert_equal 'hello', text.value
      assert_equal 'Normal', text.name

      @driver.back
    end

    def test_location_rel
      e = @core.wait { @driver.find_element :accessibility_id, 'TextFields' }
      location = e.location_rel(@driver)

      assert_equal '65.5 / 375.0', location.x
      assert_equal '196.5 / 667.0', location.y
    end
  end
end
