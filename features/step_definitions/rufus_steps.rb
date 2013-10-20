Then(/^I do not need an accessor to find the view defined "([^"]*)"$/) do |which|
  element = find(:name => which)
  element.attribute('name').should eq which
end
Given(/^I have clicked on view defined "([^"]*)" with an accessor$/) do |which|
  click(:name => which)
end
Then(/^I can print out the page data$/) do
  page_source.include?('rufusButton').should be_true
end
Then(/^I can get a list of the buttons$/) do
  elements_of_type('UIAButton').each do |element|
    element.class.name.should eq('Selenium::WebDriver::Element')
  end
end
Then(/^I can use a hash to wait for "([^"]*)" to become enabled$/) do |which|
  enabled_hash_after_wait?(:name => "#{which}").should be_true
end
Then(/^I can use a hash to wait for the "([^"]*)" view to exist$/) do |which|
  exists_hash_after_wait?(:name => "#{which}").should be_true
end