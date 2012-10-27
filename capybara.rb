require 'capybara/dsl'

include Capybara::DSL

Capybara.default_driver = :selenium

visit 'http://0.0.0.0:3000/login'
page.fill_in "Email", :with => "testing_user@gmail.com"
page.fill_in "Password", :with => "123456"
puts page.click_button "user_submit"
puts page.has_content?('Signed in successfully.')
puts page.current_path
