#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::SurveyController < ApplicationController
  layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 23
      @search = Match.search(params[:search])
      if current_user.profile_id==1
        @list_matches = @search.where(:deleted => 0, :match_type_id=>1).paginate(:page => params[:page])
      else
        @list_matches = @search.where(:deleted => 0, :user_id=>current_user.id, :match_type_id=>1).paginate(:page => params[:page])
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
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 0
      @match_type_id=1
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_status = [{:id=>0,:name=>"waiting"}, {:id=>1,:name=>'started'}, {:id=>2,:name=>'finished'}]
      @question = Question.new
      @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
    else
      no_access
    end
  end

  def create
    if current_user.has_access 24
      match = Match.new(params[:match])
      match.user_id=current_user.id
      match.match_type_id=1
      match.started=0
      begin
        if match.save
          str_desc="Se registró el match "+match.name+" con id = "+match.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"edit", :id=>match.id
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

  def edit
    @match = Match.find(params[:id])
    if current_user.has_access(26) and @match.user_id==current_user.id
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @match_type_id=@match.id
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
      @list_questions = Question.where(:match_id=>params[:id],:deleted=>0)
      @question = Question.new
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
          str_desc="Se eliminó la encuesta "+Match.find(params[:id]).name+" con id = "+params[:id].to_s
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

  def delete_question
    if current_user.has_access 47
      begin
        if Question.delete(params[:id])
          str_desc="Se eliminó el question con id = "+params[:id].to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_deleted')
        else
          flash[:alert] = t('messages.error_ocurred')
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
      end
      redirect_to("/match_management/survey/#{Question.find(params[:id]).match_id}/edit")
    else
      no_access
    end
  end

end
