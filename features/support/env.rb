$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../../', 'lib'))

require 'rufus'
require 'rspec-expectations'
require 'selenium-webdriver'
require 'require_all'
require 'rufus/driver'

World(Rufus::Navigation)

require_rel '/screens'


# Where our app lives, relative to this file
APP_PATH = '/Users/jstewart/Library/Developer/Xcode/DerivedData/RufusApp-bseyccodcsszzhcwbshowgsppecs/Build/Products/Debug-iphoneos/RufusApp.app'

#APP_PATH = '/Users/jstewart/rubymineprojects/rufus/rufusapp/frank/frankified_build/RufusApp.app'

# What we need as a capability --> iOS device, where our app is, ect.
def capabilities
  {
      'browserName' => 'iOS',
      'platform' => 'Mac',
      'version' => '6.1',
      'app' => APP_PATH
  }
end

# The location of our selenium (or in this case, Appium) file
def server_url
  "http://127.0.0.1:4723/wd/hub"
end

# Set up a driver or, if one exists, return it
def selenium

  #@driver = Rufus::Driver.new if @driver.nil?
  #@driver

  if $driver.nil?
    puts 'driver was nil'
    $driver = Rufus::Driver.new
  else
    puts 'driver was not nil'
    $driver
  end



  #@driver ||= Rufus::Driver.new
  #@driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => server_url)
end
