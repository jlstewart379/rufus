
When(/^I select the "([^"]*)" button on the alert defined "([^"]*)"$/) do |button, alert|
  on(HomePage).send("#{alert}_view").click button
end
When(/^I select the "([^"]*)" button on the alert$/) do |button|
  on(HomePage).send("alert_#{button}")
end
Then(/^I see the alert defined "([^"]*)" is displayed$/) do |which|
  on(HomePage).send("alert_#{which}_view").displayed?.should be_true
end
Then(/^I see the Rufus Alert is displayed$/) do
  on(HomePage).alert_rufus_view.should_not be_nil
end