class MatchaccessMatch < ActiveRecord::Base
  belongs_to :match
  belongs_to :match_access
end
