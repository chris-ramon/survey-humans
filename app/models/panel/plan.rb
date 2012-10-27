class Panel::Plan < ActiveRecord::Base
  def self.get_all_plans
    free = Panel::Plan.find(5, :select => 'id, name, amount')
    basic = Panel::Plan.find(1, :select => 'id, name, amount')
    pro = Panel::Plan.find(2, :select => 'id, name, amount')
    return [free, basic, pro]
  end
end
