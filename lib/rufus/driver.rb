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
      selenium
    end

    def start
      selenium.start
    end

    def quit
      selenium.quit
      @selenium_driver = nil
    end

    def find(locator)
     selenium.find(locator)
    end

    def cells(locator)
     selenium.cells(locator)
    end

    def exists?(locator)
      selenium.exists?(locator)
    end

    def click(locator)
     selenium.click(locator)
    end

    def press_button name
     selenium.press_button name
    end

    def enabled?(locator)
      selenium.enabled?(locator)
    end

    def displayed?(locator)
      selenium.displayed?(locator)
    end

    def text(locator)
      selenium.text(locator)
    end

    def class(locator)
      selenium.class(locator)
    end

    def orientation
      selenium.orientation.to_s
    end

    def rotate(orientation)
      selenium.rotate orientation
    end

    def type(keys, name)
      selenium.type(keys, name)
    end

    def sequence(*names, times)
      selenium.sequence(names, times, 1)
    end

    def buttons
      selenium.buttons
    end

    def text_fields
      selenium.text_fields
    end

    def labels
      selenium.labels
    end

    def timed_sequence(names, times, seconds)
      selenium.timed_sequence(names, times, seconds)
    end

    def find_alert(locator)
      selenium.find_alert(locator)
    end

    def click_alert(button)
      selenium.click_alert(button)
    end

    def alert_shown?
      selenium.alert_shown?
    end

    def class_for(element)
      selenium.class_for(element)
    end

    def match?(element, name)
      selenium.match?
    end

    def page_source
      selenium.page_source
    end

    def all_elements
      selenium.all_elements
    end

    def elements_by_tag(name)
      selenium.elements_by_tag name
    end

    def scroll_to(locator)
      selenium.scroll_to(locator)
    end

    def screenshot(name)
      selenium.screenshot name
    end

    def selenium
      @selenium ||= Rufus::Drivers::DriverFactory.driver_for(@config)
    end
  end
end
