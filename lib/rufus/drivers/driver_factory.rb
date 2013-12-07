module Rufus
  module Drivers
    class DriverFactory

      def self.driver_for(config, url)
        @url = url
        return ios_driver_for(config) if is_ios? config
      end

      private

      def self.ios_driver_for(config)
        return ios_physical_driver_for(config) if use_physical(config)
        ios_simulator_driver_for(config)
      end

      def self.is_ios?(config)
        config["browser"].eql?("iOS")
      end

      def self.use_physical(config)
        return config["use_physical"] unless config["use_physical"].nil?
        false
      end

      def self.ios_physical_driver_for(config)
        return Rufus::Drivers::IOS_FasterDevice.new(config, @url) if config["read_page_source"]
        Rufus::Drivers::IOS_Device.new(config, @url)
      end

      def self.ios_simulator_driver_for(config)
        return Rufus::Drivers::IOS_FasterSimulator.for(config, @url) if config["read_page_source"]
        Rufus::Drivers::IOS_Simulator.for(config, @url)
      end
    end
  end
end