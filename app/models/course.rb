class Course < ActiveRecord::Base
	belongs_to :user
	has_many :students, :dependent => :destroy

	accepts_nested_attributes_for :students, :reject_if => lambda { |a| a[:code].blank? }, :allow_destroy => true

	def self.delete(id)
		return update_all({:deleted=>1, :updated_at=>Time.now},{:id=>id})
	end
	
end
