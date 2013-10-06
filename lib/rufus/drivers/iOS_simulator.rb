require 'selenium-webdriver'

module Rufus
  module Drivers
    class IOS_Simulator

      def self.for(config,url)
        @config = config
        Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => url)
        #driver(url)
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
    end
  end
end
