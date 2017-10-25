require 'test_helper'

class AppiumLibCoreTest
  module Ios
    class SearchContextTest < Minitest::Test
      def setup
        @core ||= ::Appium::Core.for(self, Caps::IOS_OPS)
        @driver ||= @core.start_driver
      end

      def test_uiautomation
        if @core.automation_name != :xcuitest
          e = @driver.find_element :predicate, 'wdName == "Buttons"'
          assert !e.name.nil?
        else
          assert true
        end

      end

      def test_predicate
        e = @driver.find_element :predicate, 'wdName == "Buttons"'
        assert_equal 'Buttons', e.name
      end
    end
  end
end
