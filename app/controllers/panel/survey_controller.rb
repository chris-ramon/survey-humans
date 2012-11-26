#encoding: utf-8
class Panel::SurveyController < ApplicationController
  layout "_base_front"
  def index
  	
  end

  def show
  	id = Match.get_id_by_parameter(params[:id])
  	@match = Match.find id
  	@list_questions = Question.where(:match_id=>id,:deleted=>0)
  end

  def submit_survey
  	match = Match.find params[:match_id]
  	list_questions = Question.where(:match_id=>match.id, :deleted=>0)
  	list_questions.each do |question|
      begin
    		question_id = params["question_#{question.id}"]
    		case Question.find(question_id).answer_format_id
    			when 2,5,6
    				list_answers = Answer.where(:question_id=>question_id,:deleted=>0)
    				param_answers=Array.new
    				list_answers.each do |ans|
    					if !params["answer_#{ans.id}"].nil?
    						param_answers << params["answer_#{ans.id}"]
    					end
    				end
    				answer = param_answers.join("@")
    			else
    				answer = params["answer_#{question.id}"]
    		end
        solution = Solution.new
        solution.match_id=params[:match_id]
        solution.question_id=question.id
        if question.answer_format_id==8
          solution.answer=""
          if !params["answer_#{question.id}"].nil?
            image = params["answer_#{question.id}"]["image"]
            solution.image_file_name = image.original_filename
            solution.image_content_type = image.content_type
            solution.image_file_size = image.size
            solution.image_updated_at = Time.now
            fileDir = "public/images/surveyhumans"
            File.open(File.join(fileDir, image.original_filename), "wb") { |f| f.write(image.tempfile.read) }
          end
        else
          solution.answer=answer
        end
        if solution.save
          str_desc="Se agrego una solucion para la pregunta con id"+question.id.to_s+" y el solution id = "+solution.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>1})
        else
          flash[:alert] = get_errors(speaker)
          redirect_to :action=>"error"
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
        redirect_to :action=>"error"
      end
  	end
    flash[:notice] = t('messages.successfully_created')
    redirect_to :action=>"success"
  end

  def success

  end

  def error

  end
end
