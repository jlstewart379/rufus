require 'selenium-webdriver'

module Rufus
  module Drivers
    class IOS_Device

      def self.for(config,url)
        @config = config
         Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => url)
      end

      def self.capabilities
        {
            'browserName' => @config["browser"],
            'platform' => @config["platform"],
            'version' => @config["version"].to_s,
            'app' => @config["app"]
        }
      end
    end
    def rotate(orientation)
      orientation = orientation.to_sym
      @ios_driver.rotate orientation
    end

  end
end
