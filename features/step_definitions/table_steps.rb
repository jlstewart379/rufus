Then(/^I see the table defined "([^"]*)" is( not)? sorted$/) do |which, unsorted|
  on(TablePage).send("view_#{which}_view").sorted?.should == unsorted.nil?
end
Then(/^I can see all the children for the view defined "([^"]*)"$/) do |which|
  children = on(TablePage).send("view_#{which}_view").children
  children[0].attribute('name').should eq '1'
  children[1].attribute('name').should eq '2'
  children[2].attribute('name').should eq '3'
  children[3].attribute('name').should eq 'a'
  children[4].attribute('name').should eq 'b'
  children[5].attribute('name').should eq 'c'
  children[6].attribute('name').should eq 'd'
  children[7].attribute('name').should eq 'e'
end
Given(/^I select index "([^"]*)" of the "([^"]*)" table$/) do |index, table|
  on(TablePage).send("view_#{table}_view").click_on index.to_i
end
Given(/^I select the label "([^"]*)" in the "([^"]*)" table$/) do |which, table|
 on(TablePage).send("view_#{table}_view").click_on which
end