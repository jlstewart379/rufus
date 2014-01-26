module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def exists?
          selenium.exists?(what)
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
        selenium.text(what)
      end

      def send_keys(keys)
        selenium.type(keys, what[:name])
      end

      def class
        selenium.class(what)
      end

      def what
        key = @locator.keys[0].to_sym
        value = @locator[key]
        {key => value}
      end

      def name
        selenium.name(what)
      end

      def locator
        @locator
      end
    end
  end
end