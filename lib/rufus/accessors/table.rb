require 'rufus/accessors/view'

module Rufus
  module Accessors
    class Table < View

     def children
       selenium.children locator
     end
    end
  end
end