require 'rufus/accessors/view'

module Rufus
  module Accessors
    class Table < View

     def children
       selenium.cells locator
     end

     def sorted?
       elements_sorted children
     end

     def sorted_ascending?
       ascending? children
     end

     def sorted_descending?
       descending? children
     end

     def click_row(index)
       children[index - 1].click
     end

     private

      def elements_sorted(elements)
        return true if elements.count == 1
        descending? elements or ascending? elements
      end

      def descending?(elements)
        labels = elements.map{|element| element.attribute 'name'}
        elements = elements.map{|element| element.attribute 'name'}
        elements == labels.sort.reverse
      end

      def ascending?(elements)
        labels = elements.map{|element| element.attribute 'name'}
        elements =  elements.map{|element| element.attribute 'name'}
        elements == labels.sort

      end

      def element_names(elements)
        elements.map{|element| element.attribute 'name'}
      end

    end
  end
end