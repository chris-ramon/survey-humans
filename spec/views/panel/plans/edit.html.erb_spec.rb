require 'spec_helper'

describe "panel_plans/edit" do
  before(:each) do
    @plan = assign(:plan, stub_model(Panel::Plan,
      :name => "MyString",
      :amount => "9.99"
    ))
  end

  it "renders the edit plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_plans_path(@plan), :method => "post" do
      assert_select "input#plan_name", :name => "plan[name]"
      assert_select "input#plan_amount", :name => "plan[amount]"
    end
  end
end
