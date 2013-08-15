require 'rspec/expectations'
require 'selenium-webdriver'


# Where our app lives, relative to this file
APP_PATH = '/Users/jstewart/Documents/projects/copilot/Frank/frankified_build/CoPilot.app'

# What we need as a capability --> iOS device, where our app is, ect.
def capabilities
  {
      'browserName' => 'iOS',
      'platform' => 'Mac',
      'version' => '6.1.3 (10B329)',
      'app' => APP_PATH
  }
end

# The location of our selenium (or in this case, Appium) file
def server_url
  "http://127.0.0.1:4723/wd/hub"
end

# Set up a driver or, if one exists, return it
def selenium
  @driver ||= Selenium::WebDriver.for(:remote, :desired_capabilities => capabilities, :url => server_url)
end

After { @driver.quit }