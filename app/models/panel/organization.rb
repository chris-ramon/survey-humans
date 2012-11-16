class Panel::Organization < ActiveRecord::Base
  belongs_to :user
  has_many :panel_organization_invitations, :class_name => 'Panel::OrganizationInvitation'
  has_many :panel_organization_members, :class_name => 'Panel::OrganizationMember'
end
