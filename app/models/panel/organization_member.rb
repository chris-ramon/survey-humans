class Panel::OrganizationMember < ActiveRecord::Base
  belongs_to :user
  belongs_to :panel_organization, :class_name => 'Panel::Organization'

  def set_matches_access matches_ids
    match_access = MatchAccess.create(
        :panel_organization_member_id => self.id
    )
    matches_ids.each do |match_id|
      MatchaccessMatch.create(
        :match_access_id => match_access.id,
        :match_id => match_id.to_i
      )
    end

  end
end