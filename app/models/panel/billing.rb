class Panel::Billing < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  def is_credit_card_valid?
    true
  end

end
