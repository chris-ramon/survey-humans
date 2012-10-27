require 'spec_helper'

describe "panel_plans/show" do
  before(:each) do
    @plan = assign(:plan, stub_model(Panel::Plan,
      :name => "Name",
      :amount => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/9.99/)
  end
end
