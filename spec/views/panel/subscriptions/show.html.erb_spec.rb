require 'spec_helper'

describe "panel_subscriptions/show" do
  before(:each) do
    @subscription = assign(:subscription, stub_model(Panel::Subscription,
      :User => nil,
      :Plan => nil,
      :Deal => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
