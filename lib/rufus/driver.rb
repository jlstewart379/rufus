require 'yaml'
require 'selenium-webdriver'

module Rufus
  class Driver

    def initialize
      @config = YAML.load_file('config.yml') unless !File.exists?('config.yml')

      if @config["appium_url"].nil? || @config["appium_url"].eql?("")
        @url = 'http://127.0.0.1:4723/wd/hub'
      else
        @url = @config["appium_url"]
      end

    end

    def start
      driver.get @url
    end

    def config
      @config
    end

    def server_url
      @url
    end

    def find(locator)
      how = locator.keys[0].to_sym
      what = locator[how]
      driver.find_element(how, what)
    end

    def click(locator)
      find(locator).click
    end

    def press_button name
      click(:name => name)
    end

    def enabled?(locator)
      find(locator).enabled?
    end

    def displayed?(locator)
      find(locator).displayed?
    end

    def type(keys, name)
      locator = {:name => name}
      find(locator).send_keys keys
    end

    def sequence(*names, times)
      timed_sequence(names, times, 1)
    end

    def buttons
      buttons = []
      elements = elements_by_tag 'UIAButton'
      elements.each do |element|
        buttons << element.text
      end
      buttons
    end

    def text_fields
      fields = []
      elements = elements_by_tag 'UIATextField'
      elements.each do |element|
        fields << element.text
      end
      fields
    end

    def labels
      labels = []
      elements = elements_by_tag 'UIAStaticText'
      elements.each do |element|
        labels << element.text
      end
      labels
    end

    def timed_sequence(names, times, seconds)
      current = 0
      until current == times
        names.each do |name|
          click(:name => name)
          sleep seconds

        end
        current += 1
        puts "sequence #{current} completed"
      end
    end

    def find_alert(locator)
      all_elements.each do |element|
        if class_for(element).eql?('UIAAlert')
          alert = element if match?(element, locator[:name])
        end
      end
    end

    def class_for(element)
      element.tag_name
    end

    def match?(element, name)
      element.attribute(:name).eql? name
    end

    private
    def all_elements
      driver.find_elements(:tag_name, 'UIAElement')
    end



    def elements_by_tag(name)
      driver.find_elements(:tag_name, name)
    end

    def capabilities
      {
          'browserName' => @config["browser"],
          'platform' => @config["platform"],
          'version' => @config["version"].to_s,
          'app' => @config["app"]
      }
    end

    def driver
      @selenium ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => @url)
    end
  end
end
