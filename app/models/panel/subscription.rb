class Panel::Subscription < ActiveRecord::Base
  belongs_to :user, :class_name => "User"
  belongs_to :panel_plan, :class_name => "Panel::Plan"
  belongs_to :panel_deal, :class_name => "Panel::Deal"

  def update_subscription(billing, new_plan_id)
    plan = Panel::Plan.find(new_plan_id)
    amount = plan.amount
    credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => '4242424242424242',
        :month      => '9',
        :year       => Time.now.year + 1,
        :first_name => 'first name test',
        :last_name  => 'last name test',
        :verification_value  => '123',
        :brand  => 'visa'
    )

    ### Updating the subscription
    subscription = Panel::Subscription.where(:user_id=>billing.user_id).first

    response = Panel::SubscriptionTransaction.authorize(amount, credit_card, subscription.id)
    capture = Panel::SubscriptionTransaction.capture(amount, response.authorization, subscription.id)

    ### Updating expired date to 30 days from today.
    subscription.expired_at = Time.now + 2592000
    subscription.panel_plan_id = plan.id
    subscription.status = nil
    subscription.save

    return true
  end
end
