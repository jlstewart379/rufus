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

      #def args
      #  assign_args(:name) if @locator[:name]
      #end

      #def assign_args(sym)
      #  args = []
      #  args[0] = sym
      #  args[1] = @locator[sym]
      #  args
      #end
    end
  end
end