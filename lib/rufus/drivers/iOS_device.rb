require 'selenium-webdriver'
require 'rufus/drivers/driver_base'

module Rufus
  module Drivers
    class IOS_Device < Rufus::Drivers::DriverBase

      def initialize(config)
        @config = config
      end

      def app
        {device: @config["device"], app_path: @config["sim_app_path"]}
      end
    end
  end
end
