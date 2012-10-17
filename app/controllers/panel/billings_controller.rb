class Panel::BillingsController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/billings
  # GET /panel/billings.xml
  def index
    @panel_billings = Panel::Billing.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_billings }
    end
  end

  # GET /panel/billings/1
  # GET /panel/billings/1.xml
  def show
    @panel_billing = Panel::Billing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_billing }
    end
  end

  # GET /panel/billings/new
  # GET /panel/billings/new.xml
  def new
    @panel_billing = Panel::Billing.new
    @countries = Country.find(:all)
    @users = User.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_billing }
    end
  end

  # GET /panel/billings/1/edit
  def edit
    @countries = Country.find(:all)
    @users = User.find(:all)
    @panel_billing = Panel::Billing.find(params[:id])

  end

  # POST /panel/billings
  # POST /panel/billings.xml
  def create
    params[:panel_billing]['user_id'] = 4
    @panel_billing = Panel::Billing.new(params[:panel_billing])

    respond_to do |format|
      if @panel_billing.save
        format.html { redirect_to(@panel_billing, :notice => 'Billing was successfully created.') }
        format.xml  { render :xml => @panel_billing, :status => :created, :location => @panel_billing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_billing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/billings/1
  # PUT /panel/billings/1.xml
  def update
    @panel_billing = Panel::Billing.find(params[:id])

    respond_to do |format|
      if @panel_billing.update_attributes(params[:panel_billing])
        format.html { redirect_to(panel_subscribe_index_path, :notice => 'Billing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_billing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/billings/1
  # DELETE /panel/billings/1.xml
  def destroy
    @panel_billing = Panel::Billing.find(params[:id])
    @panel_billing.destroy

    respond_to do |format|
      format.html { redirect_to(panel_billings_url) }
      format.xml  { head :ok }
    end
  end
end
