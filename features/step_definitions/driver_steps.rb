require 'rufus/driver'

Given(/^I have created a valid appium driver for iOS$/) do
  app_path = './build/Debug-iphoneos/RufusApp.app'
  config = $driver.config
  config["browser"].should eq "iOS"
  config["platform"].should eq "Mac"
  config["version"].should eq "7.0.3"
  config["app"].should eq app_path
end
Given(/^the app is in the "([^"]*)" orientation/) do |orient|
  orientation = $driver.orientation
  orientation.should eq orient
end
When(/^I rotate the app to "([^"]*)"$/) do |orient|
  orientation = :portrait
  orientation = :landscape if orient.eql?('landscape')
  $driver.rotate orientation
end
When(/^I type "([^"]*)" into the text field defined "([^"]*)"$/) do |keys, which|
  on(HomePage).send("view_#{which}_view").send_keys keys
end
Then(/^the view marked "([^"]*)" has the text "([^"]*)"$/) do |which, keys|
  on(HomePage).send("view_#{which}_view").text.should eq keys
end
When(/^I take a screenshot called "([^"]*)"$/) do |name|
  $driver.screenshot name
end
Then(/^then the file "([^"]*)" exists$/) do |name|
  File.exists?(name).should be_true
end