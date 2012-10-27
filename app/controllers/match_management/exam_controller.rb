#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::ExamController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 23
      if current_user.profile_id==1
        @list_matches = Match.where(:deleted => 0, :match_type_id=>2).paginate(:page => params[:page])
      else
        @list_matches = Match.where(:deleted => 0, :user_id=>current_user.id, :match_type_id=>2).paginate(:page => params[:page])
      end
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
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 0
      @match_type_id=2
    else
      no_access
    end
  end

  def create
    if current_user.has_access 24
      match = Match.new(params[:match])
      match.user_id=current_user.id
      match.match_type_id=2
      begin
        if match.save
          str_desc="Se registró el match "+match.name+" con id = "+match.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"show_matches_by_match_type", :match_type_id=>2
        else
          flash[:alert] = get_errors(match)
          redirect_to :action=>"new_exam",:match=>match.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new_exam",:match=>match.attributes
      end
    else
      no_access
    end
  end

end
