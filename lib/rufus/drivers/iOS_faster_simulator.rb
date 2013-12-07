require 'rufus/drivers/iOS_simulator'

module Rufus
  module Drivers
    class IOS_FasterSimulator < Rufus::Drivers::IOS_Simulator

      def enabled?(locator)
        find(locator).enabled?
      end

      def displayed?(locator)
        find(locator).displayed?
      end

      def text(locator)
        find(locator).text
      end

      def class(locator)
        find(locator).tag_name
      end


    end
  end
end