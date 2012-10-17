require 'spec_helper'

describe "panel_deals/edit" do
  before(:each) do
    @deal = assign(:deal, stub_model(Panel::Deal,
      :panel_plan => nil,
      :deal_type => 1,
      :deal => 1
    ))
  end

  it "renders the edit deal form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_deals_path(@deal), :method => "post" do
      assert_select "input#deal_panel_plan", :name => "deal[panel_plan]"
      assert_select "input#deal_deal_type", :name => "deal[deal_type]"
      assert_select "input#deal_deal", :name => "deal[deal]"
    end
  end
end
