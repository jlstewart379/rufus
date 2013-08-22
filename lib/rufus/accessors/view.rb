module Rufus
  module Accessors
    class View
      include Rufus

      def initialize(locator={})
        @locator = locator
      end

      def exists?
        element = find_elements(args)

        if element.nil?
          false
        else
          true
        end
      end


      def args
        assign_args(:name) if @locator[:name]
      end

      def assign_args(sym)
        args = []
        args[0] = sym
        args[1] = @locator[sym]
        args
      end
    end
  end
end