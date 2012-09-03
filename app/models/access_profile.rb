class AccessProfile < ActiveRecord::Base
	belongs_to :access
	belongs_to :profile
end
