require 'page_navigation'

module Rufus
  module Navigation
    include PageNavigation

    def on(cls)
      screen = cls.new
      if screen.active?
         screen
      else
        raise "Expected #{cls} to be active"
      end
    end
  end
end
