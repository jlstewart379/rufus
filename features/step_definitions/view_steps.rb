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
Then(/^I am presented with an alert with the title "([^"]*)"$/) do |title|

end
Then(/^I see the title of the alert defined "([^"]*)" is "([^"]*)"$/) do |alert, title|
  on(HomePage).send("#{alert}_view").title.should == title
end