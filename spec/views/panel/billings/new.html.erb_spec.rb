require 'spec_helper'

describe "panel_billings/new" do
  before(:each) do
    assign(:billing, stub_model(Panel::Billing,
      :user => nil,
      :country => nil,
      :street_address => "MyString",
      :zip_code => "MyString",
      :cardholder_first_name => "MyString",
      :cardholder_last_name => "MyString",
      :number => 1,
      :cvv => 1,
      :billing_email => "MyString"
    ).as_new_record)
  end

  it "renders new billing form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_billings_path, :method => "post" do
      assert_select "input#billing_user", :name => "billing[user]"
      assert_select "input#billing_country", :name => "billing[country]"
      assert_select "input#billing_street_address", :name => "billing[street_address]"
      assert_select "input#billing_zip_code", :name => "billing[zip_code]"
      assert_select "input#billing_cardholder_first_name", :name => "billing[cardholder_first_name]"
      assert_select "input#billing_cardholder_last_name", :name => "billing[cardholder_last_name]"
      assert_select "input#billing_number", :name => "billing[number]"
      assert_select "input#billing_cvv", :name => "billing[cvv]"
      assert_select "input#billing_billing_email", :name => "billing[billing_email]"
    end
  end
end
