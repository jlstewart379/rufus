When(/^I swipe to the right on the view defined "([^"]*)"$/) do |which|
 swipe_right :name => which
end
Then(/^I can see I swiped to the view named "([^"]*)"$/) do |which|
  find(:name, "#{which}").text.should eq which
end