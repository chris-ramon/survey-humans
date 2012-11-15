class Panel::ExamController < ApplicationController
  layout "_base_front"
  def index

  end

  def show
    @match_id=params[:id]
    id = Match.get_id_by_parameter(params[:id])
    @match = Match.find id
  	@student=Student.new
  end

  def validate_user #student
    match_id=params[:match_id]
    id = Match.get_id_by_parameter(params[:match_id])
    puts id
    @student=Student.new(params[:student])
    @real_student=Student.where(:email=>@student.email, :course_id=>Match.find(id).course_id).first
    puts @real_student.inspect
    if !@real_student.nil?
      if @real_student.email==@student.email and @real_student.code==@student.code
        redirect_to :action=>"show_exam",:id=>match_id, :stu_id=>@real_student.id
      else
        redirect_to :action=>"show",:id=>match_id
      end
    else
      redirect_to :action=>"show",:id=>match_id
    end
  end

  def show_exam
    @student_id=params[:stu_id]
    id = Match.get_id_by_parameter(params[:id])
    @match = Match.find id
    @list_questions = Question.where(:match_id=>id,:deleted=>0)
  end

  def submit_exam
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
        solution.answer=answer
        solution.student_id=params[:student_id].to_i
        if solution.save
          str_desc="Se agrego una solucion para la pregunta con id"+question.id.to_s+" y el solution id = "+solution.id.to_s
          @log=Log.create!({:description=>str_desc, :user_id=>1})
        else
          flash[:alert] = get_errors(speaker)
          redirect_to :action=>"error"
        end
      rescue ActiveRecord::StatementInvalid => error
        flash[:alert] = t('messages.error_ocurred')
      end
    end
    flash[:notice] = t('messages.successfully_created')
    redirect_to :action=>"success", :id=>match, :stu_id=>params[:student_id]
  end

  def success #results
    @match = Match.find params[:id]
    @list_solutions = Solution.where(:match_id=>@match.id,:student_id=>params[:stu_id].to_i)
    @correct=Array.new
    @list_solutions.each do |sol|
      question = Question.find(sol.question_id)
      case question.answer_format_id
        when 1,2
          if sol.is_correct?
            @correct << 1
          else
            @correct << 0
          end
        else
          @correct << 2
      end
    end
  end

  def error

  end
end
