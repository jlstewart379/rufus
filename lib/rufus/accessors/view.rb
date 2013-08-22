module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def visible?
        selenium.find_element(:name, @locator)
      end
    end
  end
end