#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::QuestionController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 43
      @search = Question.search(params[:search])
      @list_questions = @search.where("deleted<2").paginate(:page => params[:page]).order('id DESC')
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_matches = Match.where(:deleted=>0)
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 44
      @question = Question.new
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_matches = Match.where(:deleted=>0)
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 44
      question = Question.new(params[:question])
      begin
        if question.save
          str_desc="Se registró el question con id = "+question.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question)
          redirect_to :action=>"new",:question=>question.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:question=>question.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 45
      @question = Question.find(params[:id])
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_matches = Match.where(:deleted=>0)
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 46
      @question = Question.find(params[:id])
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_matches = Match.where(:deleted=>0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 46
      question = Question.find(params[:id])
      question.attributes = params[:question]

      begin
        if question.save
          str_desc="Se editó el question con id = "+question.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question)
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
      redirect_to :action=>"index"
    else
      no_access
    end
  end

  def add_question
    if current_user.has_access(44)
      question = Question.new(params[:question])
      if !question.match_id.nil? and question.match_id!=0
        if current_user.id==Match.find(question.match_id).user_id
          redirect_str= question.match.match_type_id==1 ? "/match_management/survey/#{question.match_id}/edit" : "/match_management/exam/#{question.match_id}/edit"
          if Question.where(:match_id=>question.match_id,:deleted=>0).count<=100
            begin
              if question.save
                str_desc="Se registró el question con id = "+question.id.to_s
                @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
                flash[:notice] = t('messages.successfully_created')
                redirect_to(redirect_str)
              else
                flash[:alert] = get_errors(question)
                redirect_to(redirect_str)
              end
            rescue ActiveRecord::StatementInvalid => error
              flash[:alert] = t('messages.error_ocurred')
              redirect_to(redirect_str)
            end
          else
            flash[:alert] = "You cannot add more questions. Has been added 100 questions."
            redirect_to(redirect_str)
          end
        else
          no_access
        end
      else
        flash[:alert] = t('messages.error_ocurred')
        redirect_to("/match_management/survey")
      end
    else
      no_access
    end
  end

  def edit_question
    if current_user.has_access 46
      question = Question.find(params[:id])
      question.attributes = params[:question]
      if !question.match_id.nil? and question.match_id!=0
        redirect_str= question.match.match_type_id==1 ? "/match_management/survey/#{question.match_id}/edit" : "/match_management/exam/#{question.match_id}/edit"
        begin
          if question.save
            str_desc="Se editó el question con id = "+question.id.to_s
            @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
            flash[:notice] = t('messages.successfully_updated')
            redirect_to(redirect_str)
          else
            flash[:alert] = get_errors(question)
            redirect_to(redirect_str)
          end
        rescue ActiveRecord::StatementInvalid => error
          flash[:alert] = t('messages.error_ocurred')
          redirect_to(redirect_str)
        end
      else
        flash[:alert] = t('messages.error_ocurred')
        if question.match.match_type_id==1 
          redirect_to("/match_management/survey")
        else
          redirect_to("/match_management/exam")
        end
      end
    else
      no_access
    end
  end

  def choose_correct_answer
    if current_user.has_access 46
      question = Question.find(params[:id])
      
    end
  end

end
