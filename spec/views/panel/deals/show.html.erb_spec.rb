require 'spec_helper'

describe "panel_deals/show" do
  before(:each) do
    @deal = assign(:deal, stub_model(Panel::Deal,
      :panel_plan => nil,
      :deal_type => 1,
      :deal => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
