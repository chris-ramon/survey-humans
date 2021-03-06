#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::QuestionTypeController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 38
      @search = QuestionType.search(params[:search])
      @list_question_types = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 39
      @question_type = QuestionType.new
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 39
      question_type = QuestionType.new(params[:question_type])
      begin
        if question_type.save
          str_desc="Se registró el question type "+question_type.name+" con id = "+question_type.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question_type)
          redirect_to :action=>"new",:question_type=>question_type.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:question_type=>question_type.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 40
      @question_type = QuestionType.find(params[:id])
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 41
      @question_type = QuestionType.find(params[:id])
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 41
      question_type = QuestionType.find(params[:id])
      question_type.attributes = params[:question_type]

      begin
        if question_type.save
          str_desc="Se editó el question type "+question_type.name+" con id = "+question_type.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question_type)
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
    if current_user.has_access 42
      begin
        if QuestionType.delete(params[:id])
          str_desc="Se eliminó el question type "+QuestionType.find(params[:id]).name+" con id = "+params[:id].to_s
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
