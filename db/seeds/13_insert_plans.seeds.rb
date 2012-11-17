#encoding: utf-8
free_plan = Panel::Plan.create(:name => 'Free Plan', :amount => 0)
basic_plan = Panel::Plan.create(:name => 'Basic Plan',:amount => 15)
pro_plan = Panel::Plan.create(:name => 'Pro Plan',:amount => 30)

matches = Panel::Feature.create(:name => 'Matches')
organizations = Panel::Feature.create(:name => 'Organizations')
users_per_organization = Panel::Feature.create(:name => 'Users per Organization')

plans = [free_plan, basic_plan, pro_plan]
features = [matches, organizations, users_per_organization]

UP_TO = {
    free_plan.name => Panel::Plan::FREE_PLAN_FEATURES,
    basic_plan.name => Panel::Plan::BASIC_PLAN_FEATURES,
    pro_plan.name => Panel::Plan::PRO_PLAN_FEATURES
}

plans.each do |plan|
  features.each do |feature|
    Panel::Planfeature.create(
        :panel_plan => plan,
        :panel_feature => feature,
        :up_to => UP_TO[plan.name][feature.name.downcase.gsub(/ /,"_")]
    )
  end
end
