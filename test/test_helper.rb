$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'appium_lib_core'

require 'minitest/autorun'
require 'minitest'
$VERBOSE = nil

class AppiumLibCoreTest
  module Caps
    IOS_OPS = {
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
  end
end
