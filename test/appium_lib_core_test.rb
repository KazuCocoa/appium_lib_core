require 'test_helper'
require './lib/appium_lib_core'

class AppiumLibCoreTest < Minitest::Test
  def test_run_appium_for_ios
    #     # platformName takes a string or a symbol.
    #
    #     # Start iOS driver
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
    @core = ::Appium::Core.for(self, opts)
    @driver = @core.start_driver

    require 'pry'
    binding.pry
  end
end
