require 'spec_helper'

describe "panel_subscriptions/edit" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Panel::Subscription,
      :User => nil,
      :Plan => nil,
      :Deal => nil
    ))
  end

  it "renders the edit subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_subscriptions_path(@subscription), :method => "post" do
      assert_select "input#subscription_User", :name => "subscription[User]"
      assert_select "input#subscription_Plan", :name => "subscription[Plan]"
      assert_select "input#subscription_Deal", :name => "subscription[Deal]"
    end
  end
end
