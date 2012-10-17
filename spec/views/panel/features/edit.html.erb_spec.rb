require 'spec_helper'

describe "panel_features/edit" do
  before(:each) do
    @feature = assign(:feature, stub_model(Panel::Feature,
      :name => "MyString"
    ))
  end

  it "renders the edit feature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_features_path(@feature), :method => "post" do
      assert_select "input#feature_name", :name => "feature[name]"
    end
  end
end
