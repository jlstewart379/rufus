Given /^I am on the HomePage$/ do
 on(HomePage).active?.should be_true
end