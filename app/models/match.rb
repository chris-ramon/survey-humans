class Match < ActiveRecord::Base
	belongs_to :match_type
	belongs_to :question_level
	belongs_to :user
	has_many :questions
	has_many :solutions
	belongs_to :course

	# This function evaluates if a column is nullable or not in the database
	#
	# * *args*
	#   - column(_string_) -> database column to be evaluated
	# * *returns*
	#   - if the column is nullable or not
	def self.null?(column)
		columns_hash[column].null
	end
	
	# This function change user state to deleted
  	#
	# * *args*
	#   - id -> profile id
	# * *returns*
	#   - if the state update was successful or not
	def self.delete(id)
		return update_all({:deleted=>1, :updated_at=>Time.now},{:id=>id})
	end

	def get_status(status_id)
		case status_id
			when 0
				"waiting"
			when 1
				"started"
			when 2
				"finished"
		end
	end

	def deleted?(id)
		if Match.find(id).deleted==0
			"no"
		else
			"yes"
		end
	end

	def get_extension
		match_type_str = match_type_id==1 ? "survey" : "exam"
		url="http://172.18.19.228:3000/panel/#{match_type_str}/"
		param_id=id
		ext1="#{created_at.year.to_i+12}#{created_at.month.to_i+20}#{created_at.day.to_i+27}"
		ext2="#{created_at.day.to_i+54}#{created_at.month.to_i+40}#{created_at.year.to_i+24}"
		"#{url}#{ext1}#{id.to_s}#{ext2}"
	end

	def self.get_id_by_parameter(parameter)
		parameter[8..parameter.size-9]
	end

end
