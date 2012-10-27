require 'spec_helper'

describe "panel_plans/new" do
  before(:each) do
    assign(:plan, stub_model(Panel::Plan,
      :name => "MyString",
      :amount => "9.99"
    ).as_new_record)
  end

  it "renders new plan form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => panel_plans_path, :method => "post" do
      assert_select "input#plan_name", :name => "plan[name]"
      assert_select "input#plan_amount", :name => "plan[amount]"
    end
  end
end
