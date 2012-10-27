require 'spec_helper'

describe "panel_deals/index" do
  before(:each) do
    assign(:panel_deals, [
      stub_model(Panel::Deal,
        :panel_plan => nil,
        :deal_type => 1,
        :deal => 2
      ),
      stub_model(Panel::Deal,
        :panel_plan => nil,
        :deal_type => 1,
        :deal => 2
      )
    ])
  end

  it "renders a list of panel_deals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
