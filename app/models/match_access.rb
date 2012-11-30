class MatchAccess < ActiveRecord::Base
  belongs_to :panel_organization_member, :class_name => 'Panel::OrganizationMember'
  has_many :matchaccess_matches
end
