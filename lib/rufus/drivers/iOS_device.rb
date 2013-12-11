require 'selenium-webdriver'
require 'rufus/drivers/driver_base'

module Rufus
  module Drivers
    class IOS_Device < Rufus::Drivers::DriverBase

      def initialize(config)
        @config = config
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
