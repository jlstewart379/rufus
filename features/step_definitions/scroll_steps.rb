When(/^I scroll to the right on the view defined "([^"]*)"$/) do |which|
 scroll_to :name => which
end
Then(/^I can see I scrolled to the view named "([^"]*)"$/) do |which|
  find(:name => "#{which}").text.should eq which
end