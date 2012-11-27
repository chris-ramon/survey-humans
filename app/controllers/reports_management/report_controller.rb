#encoding: utf-8
class ReportsManagement::ReportController < ApplicationController
  layout "_content"
  before_filter :authenticate_user!
  def index
    if current_user.has_access 23
      @search = Match.search(params[:search])
      if current_user.profile_id==1
        @list_matches = @search.paginate(:page => params[:page])
      else
        @list_matches = @search.where(:deleted => 0, :user_id=>current_user.id).paginate(:page => params[:page])
        @list_matches = @list_matches.where("started > 0")
      end
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

  def show
  	@match=Match.find params[:id]
    if current_user.has_access(26) and @match.user_id==current_user.id
      @list_users = User.where(:deleted=>0)
      @list_question_levels = QuestionLevel.where(:deleted=>0)
      @list_match_types = MatchType.where(:deleted=>0)
      @match_type_id=@match.id
      @list_answer_formats = AnswerFormat.where(:deleted=>0)
      @list_question_types = QuestionType.where(:deleted=>0)
      @list_status = [{"id"=>0,"name"=>"waiting"}, {"id"=>1,"name"=>'started'}, {"id"=>2,"name"=>'finished'}]
      @list_questions = Question.where(:match_id=>params[:id],:deleted=>0)
      @question = Question.new
      @int_page_type = 2

      @list_students=Student.where(:course_id=>@match.course_id)
  	else 
  		no_access
  	end
  end

  def show_question
  	@question=Question.find params[:id]
  end
  
  def export_pdf
  	@match=Match.find params[:id]
  	#generar y guardar el pdf
    html = render_to_string(:layout => '_pdf', :action => "report_pdf.html.erb")
    kit = PDFKit.new(html, :margin_top=>'0.1in')
    kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf.css"
    pdf_url_file="/pdf/match_survey_#{@match.id.to_s}.pdf"
    file = kit.to_file("#{Rails.root}/public" + pdf_url_file)
    @match.pdf_url="http://localhost:3000"+ pdf_url_file
    begin
      if @match.save
         str_desc="Se registro PDF para el match survey con id "+@match.id.to_s
         @log=Log.create!({:description=>str_desc, :user_id=>current_user.id})
         flash[:notice] = t('messages.successfully_created')
          redirect_to :action=>"index"
        else
         flash[:alert] = get_errors(invoice)
         redirect_to :action=>"index"
        end
     rescue ActiveRecord::StatementInvalid => error
       flash[:alert] = t('messages.error_ocurred')#
       redirect_to :action=>"index"
     end
  end

  def show_result_student
    @student=Student.find params[:student_id]
    @list_solutions=Solution.where(:student_id=>params[:student_id],:match_id=>params[:match_id])
    @total = 0.0
    @total_correct = 0.0
    @list_solutions.each do |sol|
      @total_correct=@total_correct+sol.question.weight.to_f if sol.is_correct?
      @total=@total+sol.question.weight.to_f
    end
  end
end

