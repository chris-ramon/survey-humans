require 'spec_helper'

describe "panel_features/index" do
  before(:each) do
    assign(:panel_features, [
      stub_model(Panel::Feature,
        :name => "Name"
      ),
      stub_model(Panel::Feature,
        :name => "Name"
      )
    ])
  end

  it "renders a list of panel_features" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
