Given /^I am on the HomePage$/ do
 on(HomePage).active?.should be_true
end
When(/^I click the view defined "([^"]*)"$/) do |label|
  on(HomePage).send("view_#{label}")
end
Then(/^I am on the "([^"]*)"$/) do |page|
  on(page.to_class).active.should be_true
end