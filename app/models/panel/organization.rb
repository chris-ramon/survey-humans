class Panel::Organization < ActiveRecord::Base
  belongs_to :user
  has_many :panel_organization_invitations, :class_name => 'Panel::OrganizationInvitation'
  has_many :panel_organization_members, :class_name => 'Panel::OrganizationMember'

  class << self
    def send_invitations(users, organization, current_user)
      begin
        users.each do |user_id|
          user_id = user_id.to_i
          Panel::OrganizationInvitation.create(
              :panel_organization_id => organization.id,
              :user_id => user_id,
              :status => Panel::OrganizationInvitation::SENT
          )
          Panel::OrganizationMember.create(
              :user_id => current_user.id,
              :panel_organization_id => organization.id
          )
        end
      rescue
        #
      end
    end
  end
end
