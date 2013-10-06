require 'rufus/driver'

Given(/^I have created a valid appium driver for iOS$/) do

  app_path = '/Users/jstewart/Library/Developer/Xcode/DerivedData/RufusApp-bseyccodcsszzhcwbshowgsppecs/Build/Products/Debug-iphoneos/RufusApp.app'

  driver = Rufus::Driver.new
  config = driver.config

  config["browser"].should eq "iOS"
  config["platform"].should eq "Mac"
  config["version"].should eq 7.0
  config["app"].should eq app_path

end

Given(/^the app is in the "([^"]*)" orientation/) do |orient|

  orientation = :portrait
  orientation = :landscape if orient.eql?('landscape')

  driver = Rufus::Driver.new

  driver.rotate orientation

  orientation = driver.orientation
  orientation.should eq orient
end
When(/^I rotate the app to "([^"]*)"$/) do |orient|

  orientation = :portrait
  orientation = :landscape if orient.eql?('landscape')

  driver = Rufus::Driver.new
  driver.rotate orientation

end