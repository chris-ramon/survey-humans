class Panel::Planfeature < ActiveRecord::Base
  belongs_to :panel_plan, :class_name => 'Panel::Plan'
  belongs_to :panel_feature, :class_name => 'Panel::Feature'

  def self.get_all_plan_features
    free = Panel::Planfeature.where(:panel_plan_id => 5).select(:up_to).select(:panel_feature_id)
    basic = Panel::Planfeature.where(:panel_plan_id => 1).select(:up_to)
    pro = Panel::Planfeature.where(:panel_plan_id => 2).select(:up_to)
    return free.zip(basic, pro)
  end

end
