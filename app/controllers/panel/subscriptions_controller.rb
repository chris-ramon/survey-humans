#encoding: utf-8
class Panel::SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/subscriptions
  # GET /panel/subscriptions.json
  def index
    @panel_subscriptions = Panel::Subscription.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panel_subscriptions }
    end
  end

  # GET /panel/subscriptions/1
  # GET /panel/subscriptions/1.json
  def show
    @panel_subscription = Panel::Subscription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel_subscription }
    end
  end

  # GET /panel/subscriptions/new
  # GET /panel/subscriptions/new.json
  def new
    @panel_subscription = Panel::Subscription.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel_subscription }
    end
  end

  # GET /panel/subscriptions/1/edit
  def edit
    @panel_subscription = Panel::Subscription.find(params[:id])
    @users = User.all
    @plans = Panel::Plan.all
  end

  # POST /panel/subscriptions
  # POST /panel/subscriptions.json
  def create
    @panel_subscription = Panel::Subscription.new(params[:panel_subscription])

    respond_to do |format|
      if @panel_subscription.save
        format.html { redirect_to(@panel_subscription, :notice => 'Subscription was successfully created.') }
        format.json  { render :json => @panel_subscription, :status => :created, :location => @panel_subscription }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @panel_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/subscriptions/1
  # PUT /panel/subscriptions/1.json
  def update
    @panel_subscription = Panel::Subscription.find(params[:id])
    respond_to do |format|
      if @panel_subscription.update_attributes(params[:panel_subscription])
        format.html { redirect_to(@panel_subscription, :notice => 'Subscription was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel_subscription.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/subscriptions/1
  # DELETE /panel/subscriptions/1.json
  def destroy
    @panel_subscription = Panel::Subscription.find(params[:id])
    @panel_subscription.destroy

    respond_to do |format|
      format.html { redirect_to(panel_subscriptions_url) }
      format.json  { head :ok }
    end
  end
end
