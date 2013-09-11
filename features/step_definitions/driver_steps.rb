require 'rufus/driver'

Given(/^I have created a valid appium driver for iOS$/) do

  app_path = '/Users/jstewart/Library/Developer/Xcode/DerivedData/RufusApp-bseyccodcsszzhcwbshowgsppecs/Build/Products/Debug-iphoneos/RufusApp.app'

  driver = Rufus::Driver.new
  config = driver.config

  config["browser"].should eq "iOS"
  config["platform"].should eq "Mac"
  config["version"].should eq 6.1
  config["app"].should eq app_path

end

