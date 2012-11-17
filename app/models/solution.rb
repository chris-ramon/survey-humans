class Solution < ActiveRecord::Base
	belongs_to :match
	belongs_to :question
	has_attached_file :image, :styles => { 
		:small=> "250x100>",
      	:thumb=> "100x100#"
      	},
		:path => ":rails_root/public/images/surveyhumans/solution/:style/:basename.:extension", 
      	:url => "/images/solution/:style/:basename.:extension"

    def is_correct?
    	question = Question.find(question_id)
    	case question.answer_format_id
    		when 1
    			correct=nil
    			list_answers=Answer.where(:question_id=>question.id,:deleted=>0)
    			list_answers.each do |ans|
    				puts ans.inspect
    				if ans.is_correct=="1"
    					correct=ans.id
    				end
    			end
    			puts correct.inspect
    			if answer.to_i==correct.to_i
    				true
    			else
    				false
    			end
    		when 2
    			corrects=Array.new
    			list_answers=Answer.where(:question_id=>question.id,:deleted=>0)
    			list_answers.each do |ans|
    				if ans.is_correct=="1"
    					corrects << ans.id
    				end
    			end
    			answers_chosen = answer.split("@")
    			correct_answer=true
    			answers_chosen.each do |ans_cho|
    				if corrects.include?(ans_cho.to_i)
    					correct_answer= (correct_answer and true)
    				else
    					correct_answer= (correct_answer and false)
    				end
    			end
    			correct_answer
    		when 3
    			
    		when 4
    			
    	end
    end

    def get_chosen_answer_one_option
        answer_id = answer.to_i
        answer = Answer.find answer_id
        answer.answer
    end

    def get_chosen_answer_multiple_options
        chosen = answer.split("@")
        list="<ul>"
        chosen.each do |ans|
            list=list+"<li>"+Answer.find(ans.to_i).answer+"</li>"
        end
        (list+"</ul>").html_safe
    end

end
