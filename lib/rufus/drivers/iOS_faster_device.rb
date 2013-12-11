require 'rufus/drivers/iOS_device'
require 'rufus/parser'

module Rufus
  module Drivers
    class IOS_FasterDevice < IOS_Device

      def exists?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).exists?(locator[:name])
        else
          super locator
        end
      end
      def enabled?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).enabled?(locator[:name])
        else
          super locator
        end
      end
      def displayed?(locator)
        if contains_name_key? locator
          Rufus::Parser.new(page_source).displayed?(locator[:name])
        else
          super locator
        end
      end
      def text(locator)
        Rufus::Parser.new(page_source).value(locator[:name])
      end
      def class(locator)
        Rufus::Parser.new(page_source).class_for(locator[:name])
      end
    end
  end
end