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
        @ios_driver.rotate orientation
        #@ios_driver.send(:rotate, orientation)
      end

      def quit
        @ios_driver.quit
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
        @ios_driver = Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => url) if @ios_driver.nil?
        @ios_driver
      end
    end
  end
end
