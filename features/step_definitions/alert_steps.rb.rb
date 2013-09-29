
When(/^I select the "([^"]*)" button on the alert defined "([^"]*)"$/) do |button, alert|
  on(HomePage).send("#{alert}_view").click button
end