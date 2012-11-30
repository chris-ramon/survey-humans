module Panel::DealUsersHelper
  #def translate_deals_type(constant)
  #  return "" if constant == nil
  #  Panel::Deal::DEALS_TYPE.each { |v,k| return v if k == constant }
  #end
  #def deal_post_fix deal_type
  #  return "%" if 1 == deal_type
  #  return "free days" if 2 == deal_type
  #end
  def format_deal deal
    type = deal.panel_deal.deal_type
    #type = (deal.deal_type == 1) ? "Discount" : "Promotion"
    if type == 1
      return "Discount of (#{deal.panel_deal.deal}%) for #{deal.panel_deal.panel_plan.name} valid until #{deal.panel_deal.valid_until.strftime("%F")}"
    elsif type == 2
      return "Promotion of (#{deal.panel_deal.deal} free days) for #{deal.panel_deal.panel_plan.name} valid until #{deal.panel_deal.valid_until.strftime("%F")}"
    end
  end
end