require 'test_helper'

class AppiumLibCoreTest
  class DriverTest < Minitest::Test

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

    def test_appium_server_version
      v = @core.appium_server_version

      refute_nil v['build']['version']
      refute_nil v['build']['revision']
    end

    def test_platform_version
      assert_equal [10, 3], @core.platform_version
    end

    def test_screenshot
      file = @core.screenshot './ios_test.png'

      assert File.exist?(file.path)

      File.delete file.path
      assert !File.exist?(file.path)
    end

    def test_wait_true
      e = @core.wait_true { @driver.find_element :accessibility_id, 'UICatalog' }
      assert e.name
    end

    def test_wait
      e = @core.wait { @driver.find_element :accessibility_id, 'UICatalog' }
      assert_equal 'UICatalog', e.name
    end

    # TODO: call @driver.quit after tests
  end
end
