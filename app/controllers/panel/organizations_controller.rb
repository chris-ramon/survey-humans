class Panel::OrganizationsController < ApplicationController
  layout "_content"
  # GET /panel/organizations
  # GET /panel/organizations.xml
  def index
    @panel_organizations = Panel::Organization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @panel_organizations }
    end
  end

  # GET /panel/organizations/1
  # GET /panel/organizations/1.xml
  def show
    @panel_organization = Panel::Organization.find(params[:id])
    @members = Panel::OrganizationMember.where(:panel_organization_id=>params[:id]).all
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @panel_organization }
    end
  end

  # GET /panel/organizations/new
  # GET /panel/organizations/new.xml
  def new
    @panel_organization = Panel::Organization.new
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @panel_organization }
    end
  end

  # GET /panel/organizations/1/edit
  def edit
    @panel_organization = Panel::Organization.find(params[:id])
  end

  # POST /panel/organizations
  # POST /panel/organizations.xml
  def create
    params['panel_organization']['User'] = current_user
    @panel_organization = Panel::Organization.new(params[:panel_organization])
    respond_to do |format|
      if @panel_organization.save
        begin
          @users = params['members']
          @users.each do |user_id|
            user_id = user_id.to_i
            Panel::OrganizationInvitation.create(
                :panel_organization_id => @panel_organization.id,
                :User_id => user_id,
                :status => Panel::OrganizationInvitation::SENT
            )
          end
          rescue
          #
        end
        format.html { redirect_to(@panel_organization, :notice => 'Organization was successfully created.') }
        format.xml  { render :xml => @panel_organization, :status => :created, :location => @panel_organization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @panel_organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/organizations/1
  # PUT /panel/organizations/1.xml
  def update
    @panel_organization = Panel::Organization.find(params[:id])

    respond_to do |format|
      if @panel_organization.update_attributes(params[:panel_organization])
        format.html { redirect_to(@panel_organization, :notice => 'Organization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @panel_organization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/organizations/1
  # DELETE /panel/organizations/1.xml
  def destroy
    @panel_organization = Panel::Organization.find(params[:id])
    @panel_organization.destroy

    respond_to do |format|
      format.html { redirect_to(panel_organizations_url) }
      format.xml  { head :ok }
    end
  end
end
