#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::AnswerFormatController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    @current_view = "match"
    if current_user.has_access 53
      @search = AnswerFormat.search(params[:search])
      @list_answer_formats = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def new
    if current_user.has_access 54
      @answer_format = AnswerFormat.new
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 54
      answer_format = AnswerFormat.new(params[:answer_format])
      begin
        if answer_format.save
          str_desc="Se registró el answer format "+answer_format.name+" con id = "+answer_format.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(answer_format)
          redirect_to :action=>"new",:answer_format=>answer_format.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:answer_format=>answer_format.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 55
      @answer_format = AnswerFormat.find(params[:id])
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 56
      @answer_format = AnswerFormat.find(params[:id])
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 56
      answer_format = AnswerFormat.find(params[:id])
      answer_format.attributes = params[:answer_format]

      begin
        if answer_format.save
          str_desc="Se editó el answer format "+answer_format.name+" con id = "+answer_format.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(answer_format)
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
    if current_user.has_access 57
      begin
        if AnswerFormat.delete(params[:id])
          str_desc="Se eliminó el answer format "+AnswerFormat.find(params[:id]).name+" con id = "+params[:id].to_s
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
