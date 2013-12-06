Given(/^I have created an optimized driver for iOS$/) do
  app_path = './build/Debug-iphoneos/RufusApp.app'
  config = $driver.config
  config["browser"].should eq "iOS"
  config["platform"].should eq "Mac"
  config["version"].should eq "7.0.3"
  config["app"].should eq app_path
  config["use_page_source"].should eq true
end