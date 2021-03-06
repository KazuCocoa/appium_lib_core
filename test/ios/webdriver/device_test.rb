require 'test_helper'

# $ rake ios TEST=test/ios/webdriver/device_test.rb
class AppiumLibCoreTest
  module WebDriver
    class DeviceTest < Minitest::Test
      def setup
        @@core ||= ::Appium::Core.for(self, Caps::IOS_OPS)
        @@driver ||= @@core.start_driver
      end

      def test_capabilities
        assert @@driver.capabilities
      end

      def test_remote_status
        status = @@driver.remote_status

        assert !status['build']['version'].nil?
        assert !status['build']['revision'].nil?
      end

      def test_set_immediate_value
        @@core.wait { @@driver.find_element :accessibility_id, 'TextFields' }.click

        e = @@core.wait { @@driver.find_element :name, '<enter text>' }
        e.click

        @@driver.set_immediate_value e, 'hello'

        # Using predicate case
        e = @@core.wait { @@driver.find_element :predicate, by_predicate('hello') }

        assert_equal 'Normal', e.name
        assert_equal 'hello', e.value

        @@driver.back
      end

      def by_predicate(value)
        %(name ==[c] "#{value}" || label ==[c] "#{value}" || value ==[c] "#{value}")
      end

      def test_page_source
        assert @@driver.page_source
      end

      def test_location
        latitude = 100
        longitude = 100
        altitude = 75
        @@driver.set_location(latitude, longitude, altitude)

        loc = @@driver.location # check the location
        assert_equal 100, loc.latitude
        assert_equal 100, loc.longitude
        assert_equal 75, loc.altitude
      end

      def test_accept_alert
        @@core.wait { @@driver.find_element :accessibility_id, 'Alerts' }.click

        @@core.wait { @@driver.find_element :accessibility_id, 'Show OK-Cancel' }.click

        assert_equal 'UIActionSheet <title>', @@driver.switch_to.alert.text
        assert @@driver.switch_to.alert.accept

        @@driver.back
      end

      def test_dismiss_alert
        @@core.wait { @@driver.find_element :accessibility_id, 'Alerts' }.click

        @@core.wait { @@driver.find_element :accessibility_id, 'Show OK-Cancel' }.click

        assert_equal 'UIActionSheet <title>', @@driver.switch_to.alert.text
        assert @@driver.switch_to.alert.dismiss

        @@driver.back
      end

      def test_implicit_wait
        # checking no method error
        assert(@@driver.manage.timeouts.implicit_wait = @@core.default_wait)
      end

      def test_rotate
        assert_equal :portrait, @@driver.orientation

        @@driver.rotation = :landscape
        assert_equal :landscape, @@driver.orientation

        @@driver.rotation = :portrait
        assert_equal :portrait, @@driver.orientation
      end
    end
  end
end
