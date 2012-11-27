#encoding: utf-8
class Panel::PlansController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/plans
  # GET /panel/plans.json
  before_filter :current_module
  def current_module
    @current_module = "plans"
  end
  def index
    @panel_plans = Panel::Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panel_plans }
    end
  end

  # GET /panel/plans/1
  # GET /panel/plans/1.json
  def show
    @panel_plan = Panel::Plan.find(params[:id])
    @features = Panel::Planfeature.where(:panel_plan_id => params[:id]).all

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel_plan }
    end
  end

  # GET /panel/plans/new
  # GET /panel/plans/new.json
  def new
    @panel_plan = Panel::Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel_plan }
    end
  end

  # GET /panel/plans/1/edit
  def edit
    @panel_plan = Panel::Plan.find(params[:id])
  end

  # POST /panel/plans
  # POST /panel/plans.json
  def create
    @panel_plan = Panel::Plan.new(params[:panel_plan])

    respond_to do |format|
      if @panel_plan.save
        format.html { redirect_to(@panel_plan, :notice => 'Plan was successfully created.') }
        format.json  { render :json => @panel_plan, :status => :created, :location => @panel_plan }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @panel_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/plans/1
  # PUT /panel/plans/1.json
  def update
    @panel_plan = Panel::Plan.find(params[:id])

    respond_to do |format|
      if @panel_plan.update_attributes(params[:panel_plan])
        format.html { redirect_to(@panel_plan, :notice => 'Plan was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/plans/1
  # DELETE /panel/plans/1.json
  def destroy
    @panel_plan = Panel::Plan.find(params[:id])
    @panel_plan.destroy

    respond_to do |format|
      format.html { redirect_to(panel_plans_url) }
      format.json  { head :ok }
    end
  end
end
