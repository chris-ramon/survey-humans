module ApplicationHelper
  
  # Allows to set the _title_ header.
  #
  # * *args*
  #   - title(_string_) -> title name to be set   
  def title(title)
    content_for(:title) {title}
  end

  # Allows to add the javascript files into the header.
  #
  # * *args*
  #   - files(_string_) -> list of javascript files, comma separated
  def javascript(*files)
    content_for(:head) {javascript_include_tag(*files)}
  end

  # Allows to add the stylesheet files into the header.
  #
  # * *args*
  #   - files(_string_) -> list of stylesheet files, comma separated
  def stylesheet(*files)
    content_for(:head) {stylesheet_link_tag(*files)}
  end

  # This function is used in forms to indicate if a field is required or not.
  #
  # * *args*
  #   - nullable(_bool_)
  # * *returns*
  #   - a red-colored * if nullable
  def set_label_obligatory(nullable)
    return (nullable)? "":"<span style=\"color:red\">(*) </span>".html_safe
  end

  # This function is used in the jquery validations to indicate if a field is optional or required
  #
  # * *args*
  #   - nullable(_bool_)
  # * *returns*
  #   - optional or required
  def set_validate(nullable)
    return (nullable)? "optional":"required"
  end

  # This function disable all input field in a specified form. Buttons are omitted
  #
  # * *args*
  #   - form(_string_) -> the form id which inputs will be disabled
  def disabled_info(form)
    "<script type='text/javascript'>
      $().ready(function() {
  		  $('##{form} :input').attr('disabled', true);
  		  $('##{form} :input.button').attr('disabled', false);
      });</script>".html_safe
  end

  # This function implements the loading gif when the specified search form is submitted
  #
  # * *args*
  #   - form(_string_) -> the search form id
  def search_loading_js form
    "<script type='text/javascript'>
      $('##{form}').bind('ajax:before', function() {
        load_close('loading_search');
      }).bind('ajax:success', function() {
        load_off('loading_search');
      });
    </script>".html_safe
  end

  # This functions allows paginate works via ajax calls
  def paginate_ajax_js
    "<script>
      $(document).ready(function() {
      $('.pagination a').attr('data-remote', 'true');
    });</script>".html_safe
  end
  
  def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block), :ext => {:auth_token => FAYE_TOKEN}}
    uri = URI.parse("http://192.168.1.35:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end

end
