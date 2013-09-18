Given /^I am on the HomePage$/ do
 on(HomePage).active?.should be_true
end
When(/^I click the view defined "([^"]*)"$/) do |label|
  on(HomePage).send("view_#{label}")
end
Then(/^I am on the "([^"]*)"$/) do |page|
  on(page.to_class).active?.should be_true
end
Then(/^I can find the "([^"]*)" view defined by "([^"]*)"$/) do |which, how|
  on(HomePage).send("#{how}_#{which}_view").should_not be_nil
end
Given(/^I can do it all$/) do

  on(HomePage).view_rufus

  on(RufusPage).active?.should be_true


  #selenium.click 'rufusButton'
  #sleep 3
  #puts 'CLICKED'
  #selenium.displayed?('rufusPageButton').should be_true
  #on(RufusPage).active?

  #on(HomePage) do |screen|
  #  screen.active?.should be_true
  #  screen.view_rufus
  #end
  #
  #sleep 3
  #on(RufusPage).active?.should be_true

end
Given(/^I start the driver$/) do
 puts selenium
end