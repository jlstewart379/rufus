require 'selenium-webdriver'

module Rufus
  module Drivers
    class IOS_Device

      def initialize(config)
        @config = config
        Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => @url)
      end

      def capabilities
        {
            'browserName' => @config["browser"],
            'platform' => @config["platform"],
            'version' => @config["version"].to_s,
            'app' => @config["app"]
        }
      end
    end
  end
end
