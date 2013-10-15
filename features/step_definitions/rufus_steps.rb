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