require_relative 'view'

module Rufus
  module Accessors
    class Alert < View
      def title
        alert = selenium.find_alert(what)
        alert.attribute('name')
      end
    end
  end
end