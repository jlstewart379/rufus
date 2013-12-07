require 'yaml'
require 'rufus/drivers/iOS_device'
require 'rufus/drivers/iOS_simulator'
require 'selenium-webdriver'
require 'erb'
require 'selenium/webdriver/safari/extension'

module Rufus
  class Driver

    def initialize
      raise 'No config.yml found' if !File.exists?('config.yml')
      @config = YAML.load(ERB.new(File.read('config.yml')).result)
      @url = url(@config)
      driver
    end



    def driver

      @selenium ||= Rufus::Drivers::DriverFactory.driver_for(@config, @url)

      #if use_device
      #  @selenium ||= Rufus::Drivers::IOS_Device.for(@config,@url)
      #else
      #  @selenium ||= Rufus::Drivers::IOS_Simulator.for(@config,@url)
      #end
    end

    #def use_device
    #  @config["use_physical"] == true
    #end
  end
end
