module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def exists?
        element = selenium.find(what)
        false
        true unless element.nil?
      end

      def click
        selenium.find(what).click
      end

      def displayed?
        selenium.find(what).displayed?
      end

      def enabled?
        selenium.find(what).enabled?
      end

      def text
        selenium.find(what).text
      end

      def send_keys(keys)
        selenium.find(what).send_keys keys
      end

      private
      def how
        :name if @locator[:label] || @locator[:text]
      end

      def what
        @locator[:label] unless @locator[:label].nil?
        #@locator[:text] unless @locator[:text].nil?
      end
    end
  end
end