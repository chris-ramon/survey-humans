class Panel::Deal < ActiveRecord::Base
  belongs_to :panel_plan, :class_name => "Panel::Plan"
  validates :deal, :numericality => {:greater_than_or_equal_to => 0.01}
  DEALS_TYPE = [['Discount', 1], ['Promotion', 2]]

end
