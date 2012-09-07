#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class AccountManagement::ProfileController < ApplicationController
  layout "_content"  
  before_filter :authenticate_user!
  
  def index
    @current_view = "security"
    if current_user.has_access 7
      @search = Profile.search(params[:search])
      @list_profiles = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html 
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 8
      @profile = Profile.new
      @list_profile_access = AccessProfile.find :all, :conditions => {:profile_id => 0, :deleted=>0}
      @list_parent_access = Access.where(:parent_id => 0)
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 8
      profile = Profile.new(params[:profile])
      list_access = Access.all
      list_access.each do |access|
        bool_deleted = (params["access_"+access.id.to_s].to_i == 1)? 0:1
        profile.access_profiles.build({:access_id=>access.id, :deleted=>bool_deleted})
      end

      begin
        if profile.save
          str_desc="Se registró el perfil "+profile.name+" con id = "+profile.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(profile)
          redirect_to :action=>"new",:profile=>profile.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:profile=>profile.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 9
      @profile = Profile.find params[:id]
      @list_profile_access = AccessProfile.find :all, :conditions => {:profile_id => @profile.id, :deleted=>0}
      @list_parent_access = Access.where(:parent_id => 0)
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 10
      @profile = Profile.find params[:id]
      @list_profile_access = AccessProfile.find :all, :conditions => {:profile_id => @profile.id, :deleted=>0}
      @list_parent_access = Access.where(:parent_id => 0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 10
      profile = Profile.find params[:id]
      profile.attributes = params[:profile]

      profile.access_profiles.each do |access_profile|
        db_a_p = profile.access_profiles.detect {|t| t.id == access_profile.id}
        db_a_p.deleted = (params["access_"+access_profile.access_id.to_s].to_i == 1)? 0:1
      end

      begin
        if profile.save
          str_desc="Se editó el perfil "+profile.name+" con id = "+profile.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(profile)
          redirect_to :action=>"edit",:id=>params[:id]
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"edit",:id=>params[:id]
      end
    else
      no_access
    end    
  end

  def destroy
    if current_user.has_access 11
      begin
        if Profile.delete(params[:id])
          str_desc="Se eliminó el perfil "+Profile.find(params[:id]).name+" con id = "+params[:id].to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_deleted')
        else
          flash[:alert] = t('messages.error_ocurred')
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
      end
      redirect_to :action=>"index"
    else
      no_access
    end
  end

end
