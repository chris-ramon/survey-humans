class Panel::OrganizationMember < ActiveRecord::Base
  belongs_to :User
  belongs_to :panel_organization, :class_name => 'Panel::Organization'
end