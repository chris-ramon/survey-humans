class Panel::PlansController < ApplicationController
  before_filter :authenticate_user!
  layout "_content"
  # GET /panel/plans
  # GET /panel/plans.xml
  before_filter :current_module
  def current_module
    @current_module = "plans"
  end
  def index
    @panel_plans = Panel::Plan.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_plans }
    end
  end

  # GET /panel/plans/1
  # GET /panel/plans/1.xml
  def show
    @panel_plan = Panel::Plan.find(params[:id])
    @features = Panel::Planfeature.where(:panel_plan_id => params[:id]).all

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_plan }
    end
  end

  # GET /panel/plans/new
  # GET /panel/plans/new.xml
  def new
    @panel_plan = Panel::Plan.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_plan }
    end
  end

  # GET /panel/plans/1/edit
  def edit
    @panel_plan = Panel::Plan.find(params[:id])
  end

  # POST /panel/plans
  # POST /panel/plans.xml
  def create
    @panel_plan = Panel::Plan.new(params[:panel_plan])

    respond_to do |format|
      if @panel_plan.save
        format.html { redirect_to(@panel_plan, :notice => 'Plan was successfully created.') }
        format.xml  { render :xml => @panel_plan, :status => :created, :location => @panel_plan }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/plans/1
  # PUT /panel/plans/1.xml
  def update
    @panel_plan = Panel::Plan.find(params[:id])

    respond_to do |format|
      if @panel_plan.update_attributes(params[:panel_plan])
        format.html { redirect_to(@panel_plan, :notice => 'Plan was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_plan.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/plans/1
  # DELETE /panel/plans/1.xml
  def destroy
    @panel_plan = Panel::Plan.find(params[:id])
    @panel_plan.destroy

    respond_to do |format|
      format.html { redirect_to(panel_plans_url) }
      format.xml  { head :ok }
    end
  end
end
