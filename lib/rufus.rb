require 'rufus/navigation'
require 'rufus/accessors/accessors'
require 'rufus/accessors/view'

module Rufus

  def self.included(cls)
    cls.extend Rufus::Accessors
  end

  def wait_until_exists(view, timeout = 5)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout
    begin
      wait.until{view.exists?}
    rescue Selenium::WebDriver::Error::TimeOutError
      return false
    end
    true
  end
end


