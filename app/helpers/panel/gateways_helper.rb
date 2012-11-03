module Panel::GatewaysHelper
  def status bool
    bool ? "Active" : "Inactive"
  end
end
