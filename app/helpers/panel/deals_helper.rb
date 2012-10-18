module Panel::DealsHelper
  def translate_deals_type(constant)
    return "" if constant == nil
    Panel::Deal::DEALS_TYPE.each { |v,k| return v if k == constant }
  end
  def deal_post_fix deal_type
    return "%" if 1 == deal_type
    return "free days" if 2 == deal_type
  end
end
