#encoding: utf-8
# * *Page* *types*
#   - *0* -> new page
#   - *1* -> show page
#   - *2* -> edit page
class MatchManagement::ExamTopicController < ApplicationController
	layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 23
      @search = ExamTopic.search(params[:search])
      @list_exam_topics = @search.where(:deleted => 0).paginate(:page => params[:page]).order('id DESC')
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
      @exam_topic = ExamTopic.new
      @int_page_type = 0
    else
      no_access
    end
  end

  def create
    if current_user.has_access 24
      exam_topic = ExamTopic.new(params[:exam_topic])
      begin
        if exam_topic.save
          str_desc="Se registró el exam topic "+exam_topic.name+" con id = "+exam_topic.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(exam_topic)
          redirect_to :action=>"new",:exam_topic=>exam_topic.attributes
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"new",:exam_topic=>exam_topic.attributes
      end
    else
      no_access
    end
  end

  def show
    if current_user.has_access 25
      @exam_topic = ExamTopic.find(params[:id])
      @int_page_type = 1
    else
      no_access
    end
  end

  def edit
    if current_user.has_access 26
      @exam_topic = ExamTopic.find(params[:id])
      @int_page_type = 2
    else
      no_access
    end
  end

  def update
    if current_user.has_access 26
      exam_topic = ExamTopic.find(params[:id])
      exam_topic.attributes = params[:exam_topic]

      begin
        if exam_topic.save
          str_desc="Se editó el exam topic "+exam_topic.name+" con id = "+exam_topic.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
          flash[:notice] = t('messages.successfully_updated')
          redirect_to :action=>"index"
        else
          flash[:alert] = get_errors(exam_topic)
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
        if ExamTopic.delete(params[:id])
          str_desc="Se eliminó el exam topic "+ExamTopic.find(params[:id]).name+" con id = "+params[:id].to_s
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
