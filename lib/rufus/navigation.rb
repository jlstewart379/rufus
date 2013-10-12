require 'page_navigation'

module Rufus
  module Navigation
    include PageNavigation

    def on(cls, timeout = 10, &block)
      screen = cls.new
      wait = 0
      until wait == timeout  do
        if screen.active?
          block.call screen if block
          return screen
        else
          sleep 1
          wait += 1
        end
      end
        raise "Expected #{cls} to be active"
      end
    end
end
