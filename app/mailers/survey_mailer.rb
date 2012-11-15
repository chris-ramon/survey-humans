class SurveyMailer < ActionMailer::Base
  default :from => "welcome@surveyhumans.com"
  def welcome_to_survey_humans(user)
  	mail(:to => "<#{user.email}>", :subject => "Welcome to Survey Humans")
  end

  def send_survey_by_generated_url(user,survey,emails,message)
  	@survey=survey
  	@message=message
    mail(:to => "#{emails}", :subject => "Hi! You have a new Survey")
  end

  def send_exam_by_generated_url(user,exam,emails,message)
  	@exam=exam
  	@message=message
    mail(:to => "#{emails}", :subject => "Hi! You have a new Exam")
  end
end
