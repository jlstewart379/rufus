module Rufus
  class Waiter

    DEFAULT_TIMEOUT = 5
    DEFAULT_INTERVAL = 0.2


    def initialize(selenium, opts={})
      @selenium = selenium
      @timeout  = opts.fetch(:timeout, DEFAULT_TIMEOUT)
      @interval = opts.fetch(:interval, DEFAULT_INTERVAL)
    end

    def until(&block)
      time = Time.now + @timeout
      while Time.now < time
        @selenium.reset_page_source
        value = block.call if block
        return value if value
        sleep @interval
      end
      false
    end
  end
end