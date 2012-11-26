#encoding: utf-8
class Panel::OrganizationInvitationsController < ApplicationController
  # GET /panel/organization_invitations
  # GET /panel/organization_invitations.json
  def index
    @panel_organization_invitations = Panel::OrganizationInvitation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @panel_organization_invitations }
    end
  end

  # GET /panel/organization_invitations/1
  # GET /panel/organization_invitations/1.json
  def show
    @panel_organization_invitation = Panel::OrganizationInvitation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @panel_organization_invitation }
    end
  end

  # GET /panel/organization_invitations/new
  # GET /panel/organization_invitations/new.json
  def new
    @panel_organization_invitation = Panel::OrganizationInvitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @panel_organization_invitation }
    end
  end

  # GET /panel/organization_invitations/1/edit
  def edit
    @panel_organization_invitation = Panel::OrganizationInvitation.find(params[:id])
  end

  # POST /panel/organization_invitations
  # POST /panel/organization_invitations.json
  def create
    @panel_organization_invitation = Panel::OrganizationInvitation.new(params[:panel_organization_invitation])

    respond_to do |format|
      if @panel_organization_invitation.save
        format.html { redirect_to(@panel_organization_invitation, :notice => 'Organization invitation was successfully created.') }
        format.json  { render :json => @panel_organization_invitation, :status => :created, :location => @panel_organization_invitation }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @panel_organization_invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /panel/organization_invitations/1
  # PUT /panel/organization_invitations/1.json
  def update
    @panel_organization_invitation = Panel::OrganizationInvitation.find(params[:id])

    respond_to do |format|
      if @panel_organization_invitation.update_attributes(params[:panel_organization_invitation])
        format.html { redirect_to(@panel_organization_invitation, :notice => 'Organization invitation was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @panel_organization_invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /panel/organization_invitations/1
  # DELETE /panel/organization_invitations/1.json
  def destroy
    @panel_organization_invitation = Panel::OrganizationInvitation.find(params[:id])
    @panel_organization_invitation.destroy

    respond_to do |format|
      format.html { redirect_to(panel_organization_invitations_url) }
      format.json  { head :ok }
    end
  end

  def update_status
    @panel_organization_invitation = Panel::OrganizationInvitation.find(params[:id].to_i)
    @panel_organization_invitation.update_attribute("status", params[:status])
    if params[:status].to_i == Panel::OrganizationInvitation::CONFIRMED
      attributes = {'user_id'=>current_user.id, 'panel_organization_id'=> @panel_organization_invitation.panel_organization.id}
      member = Panel::OrganizationMember.new(attributes)
      member.save()
    end
    redirect_to(dashboard_account_management_user_index_path, :notice => 'Invitation was successfully updated.')
  end
end
