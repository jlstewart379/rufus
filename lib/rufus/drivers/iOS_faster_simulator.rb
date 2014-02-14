require 'rufus/drivers/iOS_simulator'
require 'rufus/parser'

module Rufus
  module Drivers
    class IOS_FasterSimulator < IOS_Simulator

      def exists?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).exists?(locator)
        else
          super locator
        end
      end
      def enabled?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).enabled?(locator)
        else
          super locator
        end
      end
      def displayed?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).displayed?(locator)
        else
          super locator
        end
      end
      def text(locator)
        Rufus::Parser.new(page_source).value(locator)
      end
    end
  end
end