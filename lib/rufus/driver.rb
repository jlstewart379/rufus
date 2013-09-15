require 'yaml'
require 'selenium-webdriver'

module Rufus
  class Driver

    def initialize
      @config = YAML.load_file('config.yml') unless !File.exists?('config.yml')

      if @config["appium_url"].eql?("") || @config["appium_url"].nil?
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

    def find(name)
      driver.find_elements(:name, name)[0]
    end

    def click(name)
      find(name).click
    end

    def enabled?(name)
      find(name).enabled?
    end

    def displayed?(name)
      find(name).displayed?
    end

    def type(keys, name)
      find(name).send_keys keys
    end


    def start_sequence(*names, times)

      current = 0

      until current == times
        names.each do |name|
          click name
          sleep 1
        end
        current += 1
      end
    end

    private

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


#perhaps set or replace a config value?