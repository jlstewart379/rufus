require 'selenium-webdriver'
require 'rufus/drivers/driver_base'

module Rufus
  module Drivers
    class IOS_Simulator < Rufus::Drivers::DriverBase

      def initialize(config)
        @config = config
      end

      #def capabilities
      #  {
      #      'browserName' => @config["browser"],
      #      'platform' => @config["platform"],
      #      'version' => @config["version"].to_s,
      #      'app' => @config["sim_app_path"],
      #      'device' => "iPhoneSimulator"
      #  }
      #end

      def app
        {device: @config["device"], app_path: @config["sim_app_path"]}
      end
    end
  end
end
