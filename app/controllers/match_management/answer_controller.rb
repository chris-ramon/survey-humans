#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::AnswerController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    @current_view = "match"
    if current_user.has_access 48
      @search = Answer.search(params[:search])
      @list_answers = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      @list_questions = Question.where(:deleted=>0)
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 49
      @answer = Answer.new
      @list_questions = Question.where(:deleted=>0)
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 49
      answer = Answer.new(params[:answer])
      begin
        if answer.save
          str_desc="Se registró el answer con id = "+answer.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(answer)
          redirect_to :action=>"new",:answer=>answer.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:answer=>answer.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 50
      @answer = Answer.find(params[:id])
      @list_questions = Question.where(:deleted=>0)
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 51
      @answer = Answer.find(params[:id])
      @list_questions = Question.where(:deleted=>0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 51
      answer = Answer.find(params[:id])
      answer.attributes = params[:answer]

      begin
        if answer.save
          str_desc="Se editó el answer con id = "+answer.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(answer)
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
    if current_user.has_access 52
      begin
        if Answer.delete(params[:id])
          str_desc="Se eliminó el answer con id = "+params[:id].to_s
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

  def add_answers
    if current_user.has_access 49
      #answer = Answer.new(params[:answer])
      question = Question.find params[:id]
      if !params[:question].nil?
        if Answer.where(:question_id=>question.id,:deleted=>0).count<=50
          params[:question][:answers_attributes].values.each do |answer|
            if answer[:_destroy]==false
                @answer=Answer.create!({:answer=>answer[:answer],:question_id=>question.id})
            end
          end
          question.attributes = params[:question]
          redirect_str= question.match.match_type_id==1 ? "/match_management/survey/#{question.match_id}/edit" : "/match_management/exam/#{question.match_id}/edit"
          begin
            if question.save
              str_desc="Se registró answers para la pregunta con id = "+question.id.to_s
              @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
              flash[:notice] = t('messages.successfully_created')
              redirect_to(redirect_str)
            else
              flash[:alert] = get_errors(answer)
              redirect_to(redirect_str)
            end
          rescue ActiveRecord::StatementInvalid => error
            flash[:alert] = t('messages.error_ocurred')
            redirect_to(redirect_str)
          end
        else
          flash[:alert] = "You cannot add more answers. Has been added 50 answers."
          redirect_to(redirect_str)
        end
      else
        redirect_str= question.match.match_type_id==1 ? "/match_management/survey/#{question.match_id}/edit" : "/match_management/exam/#{question.match_id}/edit"
        flash[:notice] = "You have not added any answer to the selected question."
        redirect_to(redirect_str)
      end
    else
      no_access
    end
  end

end
