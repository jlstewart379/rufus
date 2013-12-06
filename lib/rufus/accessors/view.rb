module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def exists?
        element = selenium.find(what)
        !element.nil?
      end

      def click
        selenium.click(what)
      end

      def displayed?
        selenium.displayed?(what)
      end

      def enabled?
        selenium.enabled?(what)
      end

      def text
        selenium.find(what).text
      end

      def send_keys(keys)
        selenium.type(keys, what[:name])
      end

      def class
        selenium.find(what).tag_name
      end

      def what
        key = @locator.keys[0].to_sym
        value = @locator[key]
        {key => value}
      end

      def locator
        @locator
      end
    end
  end
end