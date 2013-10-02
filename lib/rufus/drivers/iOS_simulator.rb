require 'selenium-webdriver'

module Rufus
  module Drivers
    class IOS_Simulator

      def initialize(config)
        @config = config
        Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => @url)
      end

      def capabilities
        {
            'browserName' => @config["browser"],
            'platform' => @config["platform"],
            'version' => @config["version"].to_s,
            'app' => @config["sim_app_path"],
            'device' => "iPhoneSimulator"
        }
      end
    end
  end
end
