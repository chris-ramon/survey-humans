#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::MatchTypeController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 28
      @search = MatchType.search(params[:search])
      @list_matche_types = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 29
      @match_type = MatchType.new
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 29
      match_type = MatchType.new(params[:match_type])
      begin
        if match_type.save
          str_desc="Se registró el match type "+match_type.name+" con id = "+match_type.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(match_type)
          redirect_to :action=>"new",:match_type=>match_type.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:match_type=>match_type.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 30
      @match_type = MatchType.find(params[:id])
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 31
      @match_type = MatchType.find(params[:id])
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 31
      match_type = MatchType.find(params[:id])
      match_type.attributes = params[:match_type]

      begin
        if match_type.save
          str_desc="Se editó el match type "+match_type.name+" con id = "+match_type.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(match_type)
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
    if current_user.has_access 32
      begin
        if MatchType.delete(params[:id])
          str_desc="Se eliminó el match type "+MatchType.find(params[:id]).name+" con id = "+params[:id].to_s
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
