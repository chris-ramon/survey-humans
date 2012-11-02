class Panel::Subscription < ActiveRecord::Base
  belongs_to :user, :class_name => "User"
  belongs_to :panel_plan, :class_name => "Panel::Plan"
  belongs_to :panel_deal, :class_name => "Panel::Deal"

end
