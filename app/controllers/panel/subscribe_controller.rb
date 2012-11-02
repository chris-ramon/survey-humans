class Panel::SubscribeController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  def index
    @subscription = Panel::Subscription.where(:User_id => current_user.id).first
    @billing = Panel::Billing.where(:user_id => current_user.id).first

    if @billing.is_credit_card_valid?
      @credit_card_valid = true
    else
      @credit_card_valid = false
    end

    @plan_features = Panel::Planfeature.get_all_plan_features
    @plans = Panel::Plan.get_all_plans

    @user_current_plan = @subscription.panel_plan_id

  end

  def edit
    @panel_subscription = Panel::Subscription.where(:User_id => current_user.id).first
    @old_plan = Panel::Planfeature.where(:panel_plan_id => params[:old_plan]).all
    @new_plan = Panel::Planfeature.where(:panel_plan_id => params[:new_plan]).all
    @credit_card = Panel::Billing.where(:user_id => current_user.id).first.number
  end

  def update
    @panel_subscription = Panel::Subscription.where(:User_id => current_user.id).first
    billing = Panel::Billing.where(:user_id => current_user.id).first
    new_plan_id = params['new_plan'].to_i
    result = @panel_subscription.update_subscription(billing, new_plan_id)
    respond_to do |format|
      if result
        format.html { redirect_to(panel_subscribe_index_path, :notice => 'Subscription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { redirect_to(panel_subscribe_index_path) }
        format.xml  { render :xml => @panel_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show

  end
end
