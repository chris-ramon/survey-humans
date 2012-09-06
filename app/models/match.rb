class Match < ActiveRecord::Base
	belongs_to :match_type
	belongs_to :question_level
	belongs_to :user
	has_many :questions

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
end
