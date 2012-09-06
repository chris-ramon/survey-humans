#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::AnswerController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
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

end
