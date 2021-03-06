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
           #start with this method
     def click_on(what)
       if what.is_a? Integer
         child_elements = children
         child_elements[what - 1].click if what - 1 <= child_elements.count
       else
         click_label what
      end
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

      def click_label(which)
        children.each do |child|
         child.click if child.attribute('name').eql? which
        end
      end

    end
  end
end