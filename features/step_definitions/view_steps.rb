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
Then(/^I will not find the view marked "([^"]*)" after waiting$/) do |arg|
  view = on(HomePage).view_zilch_view
  exists_after_wait?(view).should be_false
end
When(/^the view marked "([^"]*)" exists but is( not)? displayed$/) do |which, not_displayed|
  on(DisplayedPage).active?.should be_true
  view = on(DisplayedPage).send("view_#{which}_view")
 displayed_after_wait?(view).should == not_displayed.nil?
end
When(/^the view marked "([^"]*)" is( not)? enabled$/) do |which, not_enabled|
  on(EnabledPage).active?.should be_true
  view = on(EnabledPage).send("view_#{which}_view")
  enabled_after_wait?(view).should == not_enabled.nil?
end
Then(/^in a block can see the existence of views "([^"]*)", "([^"]*)" and "([^"]*)"$/) do |view_1, view_2, view_3|
  on(HomePage) do |screen|
    screen.send("view_#{view_1}_view").exists?.should be_true
    screen.send("view_#{view_2}_view").exists?.should be_true
    screen.send("view_#{view_3}_view").exists?.should be_true
  end
end
Then(/^I can see the view defined "([^"]*)" has text "([^"]*)"$/) do |which, text|
  on(HomePage).send("view_#{which}_view").text.should == text
end
Then(/^I can determine the view defined "([^"]*)" is of type "([^"]*)"$/) do |which, type|
  on(HomePage).send("view_#{which}_view").class.should.eql?(type)
end