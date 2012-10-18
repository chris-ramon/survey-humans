Given /^I am on (.+)$/ do |page|
  visit path_to(page)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |input_name, input_value|
  page.fill_in input_name, :with => input_value
end

When /^I click the button submit$/ do
  page.click_button "user_submit"
end

Then /^I should be on my dashboard$/ do
  page.should have_content 'Signed in successfully.'
end
