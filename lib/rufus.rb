require 'rufus/navigation'
require 'rufus/accessors/accessors'
require 'rufus/accessors/view'

module Rufus

  def self.included(cls)
    cls.extend Rufus::Accessors
  end

  def exists_after_wait?(view, timeout = 5)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout
    begin
      wait.until{view.exists?}
    rescue Selenium::WebDriver::Error::TimeOutError
      return false
    end
    true
  end

  def displayed_after_wait?(view, timeout = 5)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout
    begin
      wait.until{view.displayed?}
    rescue Selenium::WebDriver::Error::TimeOutError
      return false
    end
    true
  end

  def enabled_after_wait?(view, timeout = 5)
    wait = Selenium::WebDriver::Wait.new :timeout => timeout
    begin
      wait.until{view.displayed?}
    rescue Selenium::WebDriver::Error::TimeOutError
      return false
    end
    true
  end

end


