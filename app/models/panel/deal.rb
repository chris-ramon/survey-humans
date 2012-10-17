class Panel::Deal < ActiveRecord::Base
  belongs_to :panel_plan, :class_name => "Panel::Plan"
end
