require 'rufus/accessors/view'

module Rufus
  module Accessors
    class Table < View

     def children
       selenium.cells locator
     end
    end
  end
end