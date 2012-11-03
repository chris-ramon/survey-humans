# encoding: utf-8
require 'capybara/dsl'

include Capybara::DSL

Capybara.default_driver = :selenium

visit 'http://0.0.0.0:3000/login'
page.fill_in "Email", :with => "testing_user2@gmail.com"
page.fill_in "Password", :with => "123456"
puts page.click_button "user_submit"
puts page.has_content?('Signed in successfully.')
puts page.current_path
puts page.click_link "UPDATE SUBSCRIPTION"
puts page.click_link "Edit Credit Card Information"
page.fill_in "panel_billing[street_address]", :with => "Psje Almería Mz F1 Lt 2"
page.fill_in "panel_billing[zip_code]", :with => "Lima 12"
page.select 'Perú', :from => 'panel_billing[country_id]'
page.fill_in "panel_billing[number]", :with => "4111111111111111"
page.fill_in "panel_billing[cardholder_first_name]", :with => "Tobias"
page.fill_in "panel_billing[cardholder_last_name]", :with => "Luetke"
page.fill_in "panel_billing[cvv]", :with => "123"
page.click_button "panel_billing_submit"
page.click_link "Basic Plan"
page.click_button "select_new_plan_btn"
page.click_link "site-title"
sleep(60)