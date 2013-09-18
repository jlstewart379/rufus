require 'page_navigation'

module Rufus
  module Navigation
    include PageNavigation

    def on(cls)
      screen = cls.new

      wait = 0
      until wait == 59 do

        if screen.active?
          return screen
        else
          wait += 1
        end
      end

        raise "Expected #{cls} to be active"
      end
    end
end
