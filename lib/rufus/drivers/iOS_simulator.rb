require 'selenium-webdriver'

module Rufus
  module Drivers
    class IOS_Simulator

      def self.for(config,url)
        @config = config
        driver(url)
      end

      def orientation
        @ios_driver.orientation
      end

      def rotate(orientation)
        orientation = orientation.to_sym
        puts 'here it is'
        puts orientation
        #@ios_driver.rotate orientation.to_sym
        @ios_driver.send(:rotate, orientation)
      end

      private
      def self.capabilities
        {
            'browserName' => @config["browser"],
            'platform' => @config["platform"],
            'version' => @config["version"].to_s,
            'app' => @config["sim_app_path"],
            'device' => "iPhoneSimulator"
        }
      end

      def self.driver(url)
        @ios_driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => url)
      end
    end
  end
end
