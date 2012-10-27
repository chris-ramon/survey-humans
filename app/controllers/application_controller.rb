class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  # This function applies the locale passed by params or use the default one.
  def set_locale
   I18n.locale = params[:locale] || I18n.default_locale
  end  

  # This function adds the locale params in the url
  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  #This function specifies the path to be loaded after sign out
  def after_sign_out_path_for(resource_or_scope)
    home_path
  end

  #This function generates a custom error string based in the ActiveRecord errors
  #
  # * *args*
  #   - object -> Object with errors
  # * *returns* 
  #   - a customized error string ready to be printed in the browser
  def get_errors(object)
    str_error = ""
    object.errors.each do |attr, message|
      if !message.include?("can't be blank") and !message.include?("is invalid")
        str_error = str_error + "<li>" +message + "</li>"
      end
    end
    return str_error
  end

  #This functions restrict access to a not allowed page and show a dennied access message
  def no_access
    flash[:alert] = t('messages.no_access')
      if request.env["HTTP_REFERER"] == nil
        redirect_to "/" 
      else
        redirect_to :back
      end
  end
end
