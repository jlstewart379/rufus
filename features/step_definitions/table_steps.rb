Then(/^I see the table defined "([^"]*)" is( not)? sorted$/) do |which, unsorted|
  on(TablePage).send("view_#{which}_view").sorted?.should == unsorted.nil?
end
Then(/^I can see all the children$/) do
  pending
end