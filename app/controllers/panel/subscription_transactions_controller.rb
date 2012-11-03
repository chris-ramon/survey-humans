class Panel::SubscriptionTransactionsController < ApplicationController
  before_filter :authenticate_user!, :current_module
  layout "_content"
  # GET /panel/subscription_transactions
  # GET /panel/subscription_transactions.xml
  def current_module
    @current_module = 'transactions'
  end
  def index
    @panel_subscription_transactions = Panel::SubscriptionTransaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_subscription_transactions }
    end
  end

  # GET /panel/subscription_transactions/1
  # GET /panel/subscription_transactions/1.xml
  def show
    @panel_subscription_transaction = Panel::SubscriptionTransaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_subscription_transaction }
    end
  end

  # GET /panel/subscription_transactions/new
  # GET /panel/subscription_transactions/new.xml
  def new
    @panel_subscription_transaction = Panel::SubscriptionTransaction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_subscription_transaction }
    end
  end

  # GET /panel/subscription_transactions/1/edit
  def edit
    @panel_subscription_transaction = Panel::SubscriptionTransaction.find(params[:id])
  end

  # POST /panel/subscription_transactions
  # POST /panel/subscription_transactions.xml
  def create
    @panel_subscription_transaction = Panel::SubscriptionTransaction.new(params[:panel_subscription_transaction])

    respond_to do |format|
      if @panel_subscription_transaction.save
        format.html { redirect_to(@panel_subscription_transaction, :notice => 'Subscription transaction was successfully created.') }
        format.xml  { render :xml => @panel_subscription_transaction, :status => :created, :location => @panel_subscription_transaction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_subscription_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/subscription_transactions/1
  # PUT /panel/subscription_transactions/1.xml
  def update
    @panel_subscription_transaction = Panel::SubscriptionTransaction.find(params[:id])

    respond_to do |format|
      if @panel_subscription_transaction.update_attributes(params[:panel_subscription_transaction])
        format.html { redirect_to(@panel_subscription_transaction, :notice => 'Subscription transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_subscription_transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/subscription_transactions/1
  # DELETE /panel/subscription_transactions/1.xml
  def destroy
    @panel_subscription_transaction = Panel::SubscriptionTransaction.find(params[:id])
    @panel_subscription_transaction.destroy

    respond_to do |format|
      format.html { redirect_to(panel_subscription_transactions_url) }
      format.xml  { head :ok }
    end
  end
end
