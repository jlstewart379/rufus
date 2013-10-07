When(/^I click the view defined "([^"]*)"$/) do |label|
  on(HomePage).send("view_#{label}")
end
Then(/^I am on the "([^"]*)"$/) do |page|
  on(page.to_class).active?.should be_true
end
Then(/^I can find the "([^"]*)" view defined by "([^"]*)"$/) do |which, how|
  on(HomePage).send("#{how}_#{which}_view").should_not be_nil
end
Given(/^I start the driver$/) do
 puts selenium
end

Then(/^the view defined "([^"]*)" does( not)? exist$/) do |which, exist|
  on(HomePage).send("view_#{which}_view").exists?.should == exist.nil?
end

Given(/^I have navigated to the "([^"]*)" using the "([^"]*)" route$/) do |page, which_route|
  navigate_to(page.to_class, :using => which_route.to_sym)
end