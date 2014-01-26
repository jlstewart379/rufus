require 'yaml'
require 'erb'
require 'rufus/drivers/driver_factory'

module Rufus
  class Driver

    attr_reader :config
    attr_reader :url

    def initialize
      raise 'No config.yml found' if !File.exists?('config.yml')
      @config = YAML.load(ERB.new(File.read('config.yml')).result)
      driver
    end

    def start
      driver.start
    end

    def quit
      driver.quit
      @selenium_driver = nil
    end

    def find(locator)
     driver.find(locator)
    end

    def cells(locator)
     driver.cells(locator)
    end

    def exists?(locator)
      driver.exists?(locator)
    end

    def click(locator)
     driver.click(locator)
    end

    def press_button name
     driver.press_button name
    end

    def enabled?(locator)
      driver.enabled?(locator)
    end

    def displayed?(locator)
      driver.displayed?(locator)
    end

    def text(locator)
      driver.text(locator)
    end

    def class(locator)
      driver.class(locator)
    end

    def name(locator)
      driver.name(locator)
    end

    def orientation
      driver.orientation.to_s
    end

    def rotate(orientation)
      driver.rotate orientation
    end

    def type(keys, name)
      driver.type(keys, name)
    end

    def sequence(*names, times)
      driver.sequence(names, times, 1)
    end

    def buttons
      driver.buttons
    end

    def text_fields
      driver.text_fields
    end

    def labels
      driver.labels
    end

    def timed_sequence(names, times, seconds)
      driver.timed_sequence(names, times, seconds)
    end

    def find_alert(locator)
      driver.find_alert(locator)
    end

    def click_alert(button)
      driver.click_alert(button)
    end

    def alert_shown?
      driver.alert_shown?
    end

    def class_for(element)
      driver.class_for(element)
    end

    def match?(element, name)
      driver.match?
    end

    def page_source
      driver.page_source
    end

    def all_elements
      driver.all_elements
    end

    def elements_by_tag(name)
      driver.elements_by_tag name
    end

    def scroll_to(locator)
      driver.scroll_to(locator)
    end

    def screenshot(name)
      driver.screenshot name
    end

    def reset_page_source
      driver.reset_page_source
    end

    def driver
      @selenium_driver ||= Rufus::Drivers::DriverFactory.driver_for(@config)
    end
  end
end
