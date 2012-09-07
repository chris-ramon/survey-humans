class AccountManagement::LogController < ApplicationController
  layout "_content"  

  def index
    @current_view = "security"
    if current_user.has_access 12
      @search = Log.search(params[:search])
      @list_logs = @search.paginate(:page => params[:page]).order('id DESC')
      respond_to do |format|
        format.html
        format.js
      end
    else
      no_access
    end
  end

end
