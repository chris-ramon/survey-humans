class Panel::Billing < ActiveRecord::Base
  belongs_to :user
  belongs_to :country

  def is_credit_card_valid?
    return false if self.number == nil else return true
  end

end
