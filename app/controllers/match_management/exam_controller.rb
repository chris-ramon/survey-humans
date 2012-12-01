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
      @search = Match.search(params[:search])
      if current_user.profile_id==1
        @list_matches = @search.where(:deleted => 0, :match_type_id=>2).paginate(:page => params[:page])
      else
        @list_matches = @search.where(:deleted => 0, :user_id=>current_user.id, :match_type_id=>2).paginate(:page => params[:page])
      end
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_courses = Course.where(:user_id=>current_user.id,:deleted=>0).order("name")
      @list_match_types = MatchType.where(:deleted=>0)
      @panel_id=Panel::Subscription.where(:user_id=>current_user.id).first.panel_plan_id
      @can_add=false
      matches=Match.where(:deleted => 0, :user_id=>current_user.id)
      @subscription = Panel::Subscription.where(:user_id=>current_user.id).first
      case @panel_id
        when 1
          @can_add=(matches.count<5)
        when 2
          @can_add=(matches.count<10)
        else
          @can_add=true
      end
      @plan=Panel::Plan.find(@panel_id).name
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
      @match_type_id=2
      @list_answer_formats = AnswerFormat.where(:deleted=>0,:enable_to_exams=>1)
      @list_question_types = QuestionType.where(:deleted=>0)
      @question = Question.new
      case @match.started
        when 0
          @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        when 1
          @list_status = [{"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        else
          @list_status = [{"id"=>2,"name"=>'finished'}]
      end
    else
      no_access
    end
  end

  def create
    if current_user.has_access 24
      match = Match.new(params[:match])
      match.user_id=current_user.id
      match.match_type_id=2
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
      if !@match.url.nil?
        app_id=119458701544487
        description="This is an exam."
        redirect_uri="http://www.surveyhumans.com/match_management/exam/#{params[:id]}/edit"
        @facebook_url="https://www.facebook.com/dialog/feed?app_id=#{app_id}&link=#{@match.url}&picture=http://fbrell.com/f8.jpg&name=#{@match.name}&caption=Survey%20Humans&description=#{description}&redirect_uri=#{redirect_uri}&display=popup"
        @twitter_url=@match.url
      else
        @facebook_url="#"
        @twitter_url="#"
      end
      @list_courses = Course.where(:user_id=>current_user.id,:deleted=>0).order("name")
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @match_type_id=@match.id
      @list_answer_formats = AnswerFormat.where(:deleted=>0,:enable_to_exams=>1)
      @list_question_types = QuestionType.where(:deleted=>0)
      case @match.started
        when 0
          @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        when 1
          @list_status = [{"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        else
          @list_status = [{"id"=>2,"name"=>'finished'}]
      end
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
      redirect_to("/match_management/exam/#{Question.find(params[:id]).match_id}/edit")
    else
      no_access
    end
  end

  def generate_url_for_exam
    if current_user.has_access 26
      match = Match.find params[:id]
      match.url=match.get_extension
      match.save
      flash[:notice] = "The Exam's URL has been generated."
      redirect_to("/match_management/exam/#{params[:id]}/edit")
    else
      no_access
    end
  end

  def distribute
    @match = Match.find(params[:id])
    if current_user.has_access(26) and @match.user_id==current_user.id
      if !@match.url.nil?
        #Facebook
        app_id=119458701544487
        description="This is an exam."
        redirect_uri="http://www.surveyhumans.com/match_management/exam/#{params[:id]}/edit"
        @facebook_url="https://www.facebook.com/dialog/feed?app_id=#{app_id}&link=#{@match.url}&picture=http://fbrell.com/f8.jpg&name=#{@match.name}&caption=Survey%20Humans&description=#{description}&redirect_uri=#{redirect_uri}&display=popup"
        #Twitter
        msg="We have a new exam for you. "
        @twitter_url="https://twitter.com/share?text=#{msg}&url=#{@match.url}&hashtags=SurveyHumans"
      else
        @facebook_url="#"
        @twitter_url="#"
      end
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @match_type_id=@match.id
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      case @match.started
        when 0
          @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        when 1
          @list_status = [{"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
        else
          @list_status = [{"id"=>2,"name"=>'finished'}]
      end
      @list_questions = Question.where(:match_id=>params[:id],:deleted=>0)
      @question = Question.new
      @int_page_type = 2
    else
      no_access
    end
  end

  def send_exam_by_email
    if current_user.has_access 26
      @match = Match.find params[:id]
      emails = params[:emails]
      emails_array = Array.new
      emails_array = emails.split(",")
      if !emails_array.empty?
        email_addresses=Array.new
        invalid_email_addresses=Array.new
        emails_array.each do |email|
          email=email.delete(" ")
          if email!=""
            if email =~ /\A[\w\._%-]+@[\w\.-]+\.[a-zA-Z]{2,4}\z/
              email_addresses << "<"+email+">"
            else
              invalid_email_addresses << "<"+email+">,"
            end
          end
        end
        email_text=email_addresses.join(",")
        SurveyMailer.send_exam_by_generated_url(current_user,@match,email_text,params[:message]).deliver
        flash[:notice]="Email has been sent."
      else
        flash[:alert]="Invalid email(s)."
      end
      redirect_to("/match_management/exam/#{params[:id]}/edit")
    else
      no_access
    end
  end

end
