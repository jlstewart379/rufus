require 'rufus/navigation'
require 'rufus/accessors/accessors'
require 'rufus/accessors/view'
require 'rufus/accessors/table'
require 'rufus/waiter'

module Rufus

  def self.included(cls)
    cls.extend Rufus::Accessors
  end

  def exists_after_wait?(view, timeout = 5)
    wait = Rufus::Waiter.new selenium, :timeout => timeout
    wait.until{view.exists?}
  end

  def displayed_after_wait?(view, timeout = 5)
    wait = Rufus::Waiter.new selenium, :timeout => timeout
    wait.until{view.displayed?}
  end

  def enabled_after_wait?(view, timeout = 5)
    wait = Rufus::Waiter.new selenium, :timeout => timeout
    wait.until{view.enabled?}
  end

  def enabled_hash_after_wait?(locator, timeout = 5)
    view = Rufus::Accessors::View.new locator
    enabled_after_wait? view, timeout
  end

  def exists_hash_after_wait?(locator, timeout = 5)
    view = Rufus::Accessors::View.new locator
    exists_after_wait? view, timeout
  end

  def displayed_hash_after_wait?(locator, timeout = 5)
    view = Rufus::Accessors::View.new locator
    displayed_after_wait? view, timeout
  end

  def find(locator)
    selenium.send(:driver).find(locator)
  end

  def click(locator)
    find(locator).click
  end

  def page_source
    selenium.send(:driver).page_source
  end

  def elements_of_type(type)
    selenium.send(:driver).elements_by_tag(type)
  end

  def scroll_to(locator)
    selenium.send(:driver).scroll_to(locator)
  end
end




