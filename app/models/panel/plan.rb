class Panel::Plan < ActiveRecord::Base
  FREE_PLAN = {
      'matches' => 5,
      'organizations' => 5,
      'users_per_organization' => 5
  }

  BASIC_PLAN = {
      'matches' => 10,
      'organizations' => 10,
      'users_per_organization' => 30
  }

  PRO_PLAN = {
      'matches' => 'unlimited',
      'organizations' => 'unlimited',
      'users_per_organization' => 'unlimited'
  }
  def self.get_all_plans
    free = Panel::Plan.find(5, :select => 'id, name, amount')
    basic = Panel::Plan.find(1, :select => 'id, name, amount')
    pro = Panel::Plan.find(2, :select => 'id, name, amount')
    return [free, basic, pro]
  end
end
