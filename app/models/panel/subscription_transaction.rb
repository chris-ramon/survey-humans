class Panel::SubscriptionTransaction < ActiveRecord::Base
  belongs_to :panel_subscription, :class_name => 'Panel::Subscription'
  belongs_to :panel_gateway, :class_name => 'Panel::Gateway'
  serialize :params
  cattr_accessor :gateway

  class << self
    def authorize(amount, credit_card, subscription, options = {})
      process('authorization', amount, subscription) do |gw|
        gw.authorize(amount, credit_card, options)
      end
    end
    def capture(amount, authorization, subscription, options = {})
      process('capture', amount, subscription) do |gw|
        gw.capture(amount, authorization, options)
      end
    end

    private
    def process(action, amount = nil, subscription)
      result = Panel::SubscriptionTransaction.new
      result.action = action
      result.amount = amount
      begin
        response = yield gateway
        result.panel_subscription_id = subscription
        result.success = response.success?
        result.reference = response.authorization
        result.message = response.message
        result.params = response.params
        result.test = response.test?
      rescue ActiveMerchant::ActiveMerchantError => e
        result.panel_subscription_id = subscription
        result.success = false
        result.reference = nil
        result.message = e.message
        result.params = {}
        result.test = gateway.test?
      end
      result.save
      response
    end
  end
end
