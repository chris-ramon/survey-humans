class Solution < ActiveRecord::Base
	belongs_to :match
	belongs_to :questions
	has_attached_file :image, :styles => { 
		:small=> "250x100>",
      	:thumb=> "100x100#"
      	},
		:path => ":rails_root/public/images/surveyhumans/solution/:style/:basename.:extension", 
      	:url => "/images/solution/:style/:basename.:extension"

end
