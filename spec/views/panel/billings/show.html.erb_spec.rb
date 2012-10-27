require 'spec_helper'

describe "panel_billings/show" do
  before(:each) do
    @billing = assign(:billing, stub_model(Panel::Billing,
      :user => nil,
      :country => nil,
      :street_address => "Street Address",
      :zip_code => "Zip Code",
      :cardholder_first_name => "Cardholder First Name",
      :cardholder_last_name => "Cardholder Last Name",
      :number => 1,
      :cvv => 2,
      :billing_email => "Billing Email"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Street Address/)
    rendered.should match(/Zip Code/)
    rendered.should match(/Cardholder First Name/)
    rendered.should match(/Cardholder Last Name/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Billing Email/)
  end
end
