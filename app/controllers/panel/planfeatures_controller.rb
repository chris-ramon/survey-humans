#encoding: utf-8
class Panel::PlanfeaturesController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/planfeatures
  # GET /panel/planfeatures.json
  def index
    @panel_planfeatures = Panel::Planfeature.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panel_planfeatures }
    end
  end

  # GET /panel/planfeatures/1
  # GET /panel/planfeatures/1.json
  def show
    @panel_planfeature = Panel::Planfeature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel_planfeature }
    end
  end

  # GET /panel/planfeatures/new
  # GET /panel/planfeatures/new.json
  def new
    @panel_planfeature = Panel::Planfeature.new
    @plans = Panel::Plan.all
    @features = Panel::Feature.all

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel_planfeature }
    end
  end

  # GET /panel/planfeatures/1/edit
  def edit
    @panel_planfeature = Panel::Planfeature.find(params[:id])
    @plans = Panel::Plan.all
    @features = Panel::Feature.all
  end

  # POST /panel/planfeatures
  # POST /panel/planfeatures.json
  def create
    @panel_planfeature = Panel::Planfeature.new(params[:panel_planfeature])

    respond_to do |format|
      if @panel_planfeature.save
        format.html { redirect_to(@panel_planfeature, :notice => 'Planfeature was successfully created.') }
        format.json  { render :json => @panel_planfeature, :status => :created, :location => @panel_planfeature }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @panel_planfeature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/planfeatures/1
  # PUT /panel/planfeatures/1.json
  def update
    @panel_planfeature = Panel::Planfeature.find(params[:id])

    respond_to do |format|
      if @panel_planfeature.update_attributes(params[:panel_planfeature])
        format.html { redirect_to(@panel_planfeature, :notice => 'Planfeature was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel_planfeature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/planfeatures/1
  # DELETE /panel/planfeatures/1.json
  def destroy
    @panel_planfeature = Panel::Planfeature.find(params[:id])
    @panel_planfeature.destroy

    respond_to do |format|
      format.html { redirect_to(panel_planfeatures_url) }
      format.json  { head :ok }
    end
  end
end
