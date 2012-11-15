class Solution < ActiveRecord::Base
	belongs_to :match
	belongs_to :questions
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

end
