require 'yaml'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'selenium-webdriver'
require 'erb'
require 'selenium/webdriver/safari/extension'

module Rufus
  class Driver

    attr_reader :config
    attr_reader :url

    def initialize
      raise 'No config.yml found' if !File.exists?('config.yml')
      @config = YAML.load(ERB.new(File.read('config.yml')).result)
      driver
    end
    def driver
      @selenium ||= Rufus::Drivers::DriverFactory.driver_for(@config)
    end
  end
end
