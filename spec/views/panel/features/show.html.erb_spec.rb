require 'spec_helper'

describe "panel_features/show" do
  before(:each) do
    @feature = assign(:feature, stub_model(Panel::Feature,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
