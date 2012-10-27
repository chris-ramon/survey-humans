require 'spec_helper'

describe "panel_planfeatures/edit" do
  before(:each) do
    @planfeature = assign(:planfeature, stub_model(Panel::Planfeature,
      :plan => nil,
      :feature => nil,
      :up_to => 1
    ))
  end

  it "renders the edit planfeature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_planfeatures_path(@planfeature), :method => "post" do
      assert_select "input#planfeature_plan", :name => "planfeature[plan]"
      assert_select "input#planfeature_feature", :name => "planfeature[feature]"
      assert_select "input#planfeature_up_to", :name => "planfeature[up_to]"
    end
  end
end
