require 'spec_helper'

describe "panel_subscriptions/index" do
  before(:each) do
    assign(:panel_subscriptions, [
      stub_model(Panel::Subscription,
        :User => nil,
        :Plan => nil,
        :Deal => nil
      ),
      stub_model(Panel::Subscription,
        :User => nil,
        :Plan => nil,
        :Deal => nil
      )
    ])
  end

  it "renders a list of panel_subscriptions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
