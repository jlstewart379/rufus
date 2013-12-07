require 'rufus/drivers/iOS_simulator'
require 'rufus/parser'

module Rufus
  module Drivers
    class IOS_FasterSimulator < Rufus::Drivers::IOS_Simulator

      def enabled?(locator)
        Rufus::Parser.new(page_source).enabled?(locator['name'])
      end

      #def displayed?(locator)
      #  find(locator).displayed?
      #end
      #
      #def text(locator)
      #  find(locator).text
      #end
      #
      #def class(locator)
      #  find(locator).tag_name
      #end


    end
  end
end