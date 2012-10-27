require 'spec_helper'

describe "panel_plans/index" do
  before(:each) do
    assign(:panel_plans, [
      stub_model(Panel::Plan,
        :name => "Name",
        :amount => "9.99"
      ),
      stub_model(Panel::Plan,
        :name => "Name",
        :amount => "9.99"
      )
    ])
  end

  it "renders a list of panel_plans" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
