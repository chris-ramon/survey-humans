#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::MatchController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 23
      @search = Match.search(params[:search])
      @list_matches = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 24
      @match = Match.new
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 24
      match = Match.new(params[:match])
      begin
        if match.save
          str_desc="Se registró el match "+match.name+" con id = "+match.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(match)
          redirect_to :action=>"new",:match=>match.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:match=>match.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 25
      @match = Match.find(params[:id])
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 26
      @match = Match.find(params[:id])
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 26
      match = Match.find(params[:id])
      match.attributes = params[:match]

      begin
        if match.save
          str_desc="Se editó el match "+match.name+" con id = "+match.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(match)
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
    if current_user.has_access 27
      begin
        if Match.delete(params[:id])
          str_desc="Se eliminó el match "+Match.find(params[:id]).name+" con id = "+params[:id].to_s
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

  def match_panel
  end

  def show_matches_by_match_type
    if current_user.has_access 23
      @match_type_id=params[:id]
      @list_matches = Match.where(:deleted => 0, :match_type_id=>params[:id]).paginate(:page => params[:page]).order('id DESC')
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

end
