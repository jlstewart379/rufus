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
        args = []
        #":name, '#{@locator[:name]}'" if @locator[:name]
        args[0] = :name
        args[1] = @locator[:name]
        args
      end
    end
  end
end