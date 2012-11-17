class Panel::Planfeature < ActiveRecord::Base
  belongs_to :panel_plan, :class_name => 'Panel::Plan'
  belongs_to :panel_feature, :class_name => 'Panel::Feature'

  def self.get_all_plan_features
    free_plan = Panel::Plan.where(:name => Panel::Plan::FREE_PLAN).select([:id]).first
    basic_plan =Panel::Plan.where(:name => Panel::Plan::BASIC_PLAN).select([:id]).first
    pro_plan = Panel::Plan.where(:name => Panel::Plan::PRO_PLAN).select([:id]).first
    free = Panel::Planfeature.where(:panel_plan_id => free_plan.id).select(:up_to).select(:panel_feature_id)
    basic = Panel::Planfeature.where(:panel_plan_id => basic_plan.id).select(:up_to)
    pro = Panel::Planfeature.where(:panel_plan_id => pro_plan.id).select(:up_to)
    return free.zip(basic, pro)
  end

end
