class DealUser < ActiveRecord::Base
  SENT = 2
  USED = 1
  DISMISSED = 0
  belongs_to :user
  belongs_to :panel_deal, :class_name => 'Panel::Deal'
end
