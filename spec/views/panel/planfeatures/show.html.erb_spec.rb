require 'spec_helper'

describe "panel_planfeatures/show" do
  before(:each) do
    @planfeature = assign(:planfeature, stub_model(Panel::Planfeature,
      :plan => nil,
      :feature => nil,
      :up_to => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1/)
  end
end
