require 'spec_helper'

describe "panel_billings/index" do
  before(:each) do
    assign(:panel_billings, [
      stub_model(Panel::Billing,
        :user => nil,
        :country => nil,
        :street_address => "Street Address",
        :zip_code => "Zip Code",
        :cardholder_first_name => "Cardholder First Name",
        :cardholder_last_name => "Cardholder Last Name",
        :number => 1,
        :cvv => 2,
        :billing_email => "Billing Email"
      ),
      stub_model(Panel::Billing,
        :user => nil,
        :country => nil,
        :street_address => "Street Address",
        :zip_code => "Zip Code",
        :cardholder_first_name => "Cardholder First Name",
        :cardholder_last_name => "Cardholder Last Name",
        :number => 1,
        :cvv => 2,
        :billing_email => "Billing Email"
      )
    ])
  end

  it "renders a list of panel_billings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Street Address".to_s, :count => 2
    assert_select "tr>td", :text => "Zip Code".to_s, :count => 2
    assert_select "tr>td", :text => "Cardholder First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Cardholder Last Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Billing Email".to_s, :count => 2
  end
end
