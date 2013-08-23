module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def exists?
        element = selenium.find_elements(how,what)
        false
        true unless element.nil?
      end

      def how
        :name if @locator[:label]
      end

      def what
        @locator[:label] unless @locator[:label].nil?
      end
    end
  end
end