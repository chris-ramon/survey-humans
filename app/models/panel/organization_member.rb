class Panel::OrganizationMember < ActiveRecord::Base
  belongs_to :User
end