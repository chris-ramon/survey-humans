require 'spec_helper'

describe "panel_subscriptions/new" do
  before(:each) do
    assign(:subscription, stub_model(Panel::Subscription,
      :User => nil,
      :Plan => nil,
      :Deal => nil
    ).as_new_record)
  end

  it "renders new subscription form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_subscriptions_path, :method => "post" do
      assert_select "input#subscription_User", :name => "subscription[User]"
      assert_select "input#subscription_Plan", :name => "subscription[Plan]"
      assert_select "input#subscription_Deal", :name => "subscription[Deal]"
    end
  end
end
