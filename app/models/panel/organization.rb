class Panel::Organization < ActiveRecord::Base
  belongs_to :User
  has_many :panel_organization_invitations, :class_name => 'Panel::OrganizationInvitation'
  has_many :panel_
end
