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

      def click
        selenium.find_elements(how,what).click
      end

      private
      def how
        :name if @locator[:label] || @locator[:text]

      end

      def what
        @locator[:label] unless @locator[:label].nil?
        @locator[:text] unless @locator[:text].nil?
      end
    end
  end
end