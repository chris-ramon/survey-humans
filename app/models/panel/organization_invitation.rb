class Panel::OrganizationInvitation < ActiveRecord::Base
  SENT = 2
  CONFIRMED = 1
  DISMISSED = 0

  belongs_to :User
  belongs_to :panel_organization, :class_name => 'Panel::Organization'
end