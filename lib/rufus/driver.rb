require 'yaml'
require 'selenium-webdriver'

module Rufus
  class Driver

    def initialize
      @config = YAML.load_file('config.yml') unless !File.exists?('config.yml')
      @url = 'http:127.0.0.1:4723/wd/hub'
    end

    def config
      @config
    end

    def find(name)
      driver.find_elements(:name, name)[0]
    end

    def click(name)
      find(name).click
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