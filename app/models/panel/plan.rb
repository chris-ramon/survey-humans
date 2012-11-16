class Panel::Plan < ActiveRecord::Base
  FREE_PLAN = "Free Plan"
  BASIC_PLAN = "Basic Plan"
  PRO_PLAN = "Pro Plan"
  FREE_PLAN_FEATURES = {
      'matches' => 5,
      'organizations' => 5,
      'users_per_organization' => 5
  }

  BASIC_PLAN_FEATURES = {
      'matches' => 10,
      'organizations' => 10,
      'users_per_organization' => 30
  }

  PRO_PLAN_FEATURES = {
      'matches' => 'unlimited',
      'organizations' => 'unlimited',
      'users_per_organization' => 'unlimited'
  }
  def self.get_all_plans
    free = Panel::Plan.where(:name => 'Free Plan').select('id, name, amount').first
    basic = Panel::Plan.where(:name => 'Basic Plan').select('id, name, amount').first
    pro = Panel::Plan.where(:name => 'Pro Plan').select('id, name, amount').first
    return [free, basic, pro]
  end
end
