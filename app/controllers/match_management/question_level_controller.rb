#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::QuestionLevelController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 33
      @search = QuestionLevel.search(params[:search])
      @list_question_levels = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 34
      @question_level = QuestionLevel.new
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 34
      question_level = QuestionLevel.new(params[:question_level])
      begin
        if question_level.save
          str_desc="Se registró el question level "+question_level.range+" con id = "+question_level.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question_level)
          redirect_to :action=>"new",:question_level=>question_level.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:question_level=>question_level.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 35
      @question_level = QuestionLevel.find(params[:id])
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 36
      @question_level = QuestionLevel.find(params[:id])
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 36
      question_level = QuestionLevel.find(params[:id])
      question_level.attributes = params[:question_level]

      begin
        if question_level.save
          str_desc="Se editó el question level "+question_level.range+" con id = "+question_level.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(question_level)
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
    if current_user.has_access 37
      begin
        if QuestionLevel.delete(params[:id])
          str_desc="Se eliminó el currency "+QuestionLevel.find(params[:id]).range+" con id = "+params[:id].to_s
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
