#encoding: utf-8
class Panel::DealsController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/deals
  # GET /panel/deals.json
  before_filter :current_module
  def current_module
    @current_module = "deals"
  end
  def index
    @panel_deals = Panel::Deal.all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panel_deals }
    end
  end

  # GET /panel/deals/1
  # GET /panel/deals/1.json
  def show
    @panel_deal = Panel::Deal.find(params[:id])
    ids = DealUser.where(:panel_deal_id=>@panel_deal.id)\
      .select('user_id')\
      .collect {|deal_user| deal_user.user_id}
    users_ids_with_deal = (ids.size > 0) ? ids : 0
    @users = User.where(
      'id NOT IN (?) and deleted = (?) and profile_id = (?)',
      users_ids_with_deal,
      0,
      2
    ).paginate(:page => params[:page]).order('id DESC')
    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel_deal }
    end
  end

  # GET /panel/deals/new
  # GET /panel/deals/new.json
  def new
    @panel_deal = Panel::Deal.new
    @panel_plans = Panel::Plan.all
    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel_deal }
    end
  end

  # GET /panel/deals/1/edit
  def edit
    @panel_deal = Panel::Deal.find(params[:id])
    @panel_plans = Panel::Plan.all
  end

  # POST /panel/deals
  # POST /panel/deals.json
  def create
    @panel_deal = Panel::Deal.new(params[:panel_deal])
    @panel_plans = Panel::Plan.all

    respond_to do |format|
      if @panel_deal.save
        format.html { redirect_to(@panel_deal, :notice => 'Deal was successfully created.') }
        format.json  { render :json => @panel_deal, :status => :created, :location => @panel_deal }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @panel_deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/deals/1
  # PUT /panel/deals/1.json
  def update
    @panel_deal = Panel::Deal.find(params[:id])

    respond_to do |format|
      if @panel_deal.update_attributes(params[:panel_deal])
        format.html { redirect_to(@panel_deal, :notice => 'Deal was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel_deal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/deals/1
  # DELETE /panel/deals/1.json
  def destroy
    @panel_deal = Panel::Deal.find(params[:id])
    @panel_deal.destroy

    respond_to do |format|
      format.html { redirect_to(panel_deals_url) }
      format.json  { head :ok }
    end
  end

  def send_deal
    users_id = params["users"]
    deal_id = params["deal_id"]
    users_id.each do |user_id|
      _deal_user = DealUser.create(
        :user_id => user_id.to_i,
        :panel_deal_id => deal_id.to_i,
        :validation_code => SecureRandom.urlsafe_base64,
        :status => DealUser::SENT
      )
      SurveyMailer.send_deal(_deal_user).deliver
    end
    #users = User.where('id in (?)', users_id)
    flash[:notice] = 'Deal was successfully sent.'
    redirect_to panel_deal_path deal_id
    #render :text => params
  end
end
