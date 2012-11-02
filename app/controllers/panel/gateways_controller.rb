class Panel::GatewaysController < ApplicationController
  before_filter :authenticate_user!, :current_module
  layout "_content"
  # GET /panel/gateways
  # GET /panel/gateways.xml
  def current_module
    @current_module = "gateways"
  end

  def index
    @panel_gateways = Panel::Gateway.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_gateways }
    end
  end

  # GET /panel/gateways/1
  # GET /panel/gateways/1.xml
  def show
    @panel_gateway = Panel::Gateway.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_gateway }
    end
  end

  # GET /panel/gateways/new
  # GET /panel/gateways/new.xml
  def new
    @panel_gateway = Panel::Gateway.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_gateway }
    end
  end

  # GET /panel/gateways/1/edit
  def edit
    @panel_gateway = Panel::Gateway.find(params[:id])
  end

  # POST /panel/gateways
  # POST /panel/gateways.xml
  def create
    @panel_gateway = Panel::Gateway.new(params[:panel_gateway])

    respond_to do |format|
      if @panel_gateway.save
        format.html { redirect_to(@panel_gateway, :notice => 'Gateway was successfully created.') }
        format.xml  { render :xml => @panel_gateway, :status => :created, :location => @panel_gateway }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_gateway.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/gateways/1
  # PUT /panel/gateways/1.xml
  def update
    @panel_gateway = Panel::Gateway.find(params[:id])

    respond_to do |format|
      if @panel_gateway.update_attributes(params[:panel_gateway])
        format.html { redirect_to(@panel_gateway, :notice => 'Gateway was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_gateway.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/gateways/1
  # DELETE /panel/gateways/1.xml
  def destroy
    @panel_gateway = Panel::Gateway.find(params[:id])
    @panel_gateway.destroy

    respond_to do |format|
      format.html { redirect_to(panel_gateways_url) }
      format.xml  { head :ok }
    end
  end
  def update_default_gateway
    gateway = Panel::Gateway.find(params[:id])
    action = params[:task] == "enable" ? 1 : 0
    gateway.status = action
    gateway.save
    redirect_to panel_gateways_path
  end
end
