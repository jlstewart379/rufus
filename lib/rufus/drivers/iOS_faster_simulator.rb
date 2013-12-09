require 'rufus/drivers/iOS_simulator'
require 'rufus/parser'

module Rufus
  module Drivers
    class IOS_FasterSimulator < IOS_Simulator

      def exists?(locator)
        Rufus::Parser.new(page_source).exists?(locator[:name])
      end

      def enabled?(locator)
        Rufus::Parser.new(page_source).enabled?(locator[:name])
      end
      def displayed?(locator)
        Rufus::Parser.new(page_source).displayed?(locator[:name])
      end

      def text(locator)
        puts 'calling parser'
        Rufus::Parser.new(page_source).value(locator[:name])
      end

      def class(locator)
        Rufus::Parser.new(page_source).class_for(locator[:name])
      end
    end
  end
end