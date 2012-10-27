class Panel::FeaturesController < ApplicationController
  # GET /panel/features
  # GET /panel/features.xml
  def index
    @panel_features = Panel::Feature.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_features }
    end
  end

  # GET /panel/features/1
  # GET /panel/features/1.xml
  def show
    @panel_feature = Panel::Feature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_feature }
    end
  end

  # GET /panel/features/new
  # GET /panel/features/new.xml
  def new
    @panel_feature = Panel::Feature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_feature }
    end
  end

  # GET /panel/features/1/edit
  def edit
    @panel_feature = Panel::Feature.find(params[:id])
  end

  # POST /panel/features
  # POST /panel/features.xml
  def create
    @panel_feature = Panel::Feature.new(params[:panel_feature])

    respond_to do |format|
      if @panel_feature.save
        format.html { redirect_to(@panel_feature, :notice => 'Feature was successfully created.') }
        format.xml  { render :xml => @panel_feature, :status => :created, :location => @panel_feature }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/features/1
  # PUT /panel/features/1.xml
  def update
    @panel_feature = Panel::Feature.find(params[:id])

    respond_to do |format|
      if @panel_feature.update_attributes(params[:panel_feature])
        format.html { redirect_to(@panel_feature, :notice => 'Feature was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/features/1
  # DELETE /panel/features/1.xml
  def destroy
    @panel_feature = Panel::Feature.find(params[:id])
    @panel_feature.destroy

    respond_to do |format|
      format.html { redirect_to(panel_features_url) }
      format.xml  { head :ok }
    end
  end
end
