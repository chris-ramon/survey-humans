require 'spec_helper'

describe "panel_planfeatures/index" do
  before(:each) do
    assign(:panel_planfeatures, [
      stub_model(Panel::Planfeature,
        :plan => nil,
        :feature => nil,
        :up_to => 1
      ),
      stub_model(Panel::Planfeature,
        :plan => nil,
        :feature => nil,
        :up_to => 1
      )
    ])
  end

  it "renders a list of panel_planfeatures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
