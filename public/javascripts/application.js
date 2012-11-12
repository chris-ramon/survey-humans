// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function open_close_div_search(str_form) {
    $('#'+str_form).slideToggle("slow");
    $('#button_search').css("color", "white");
    return true;
}

function load_close(str_id) {
    document.getElementById(str_id).style.display = "inline";
}

function load_off(str_id) {
    document.getElementById(str_id).style.display = "none";
}

function mark(list_childs, list_parents, elem)
{

  //Childs
  if (list_childs!="")
  {
    array_childs = list_childs.split(",");
    index=0;
    while (index<array_childs.length)
    {
      str_elem= "access_"+array_childs[index].toString();
      if (elem.checked) document.getElementById(str_elem).checked = true;
      else document.getElementById(str_elem).checked = false;
      index+=1;
    }
  }

  //Parents

  if (list_parents!="")
  {
    array_parents = list_parents.split(",");
    index=0;
    while (index<array_parents.length)
    {
      str_elem= "access_"+array_parents[index].toString();
      if (elem.checked) document.getElementById(str_elem).checked = true;
      index+=1;
    }
  }
}

function open_close_div(elem) {
  if (document.getElementById('list_'+elem.toString()+'').style.display == 'none'){
    document.getElementById('link_'+elem.toString()+'').textContent = "▲";
  }
  else {
    document.getElementById('link_'+elem.toString()+'').textContent = "▼";
  }
  $('#'+'list_'+elem.toString()+'').slideToggle("slow");
  return false;
}

function hide_sidebar(){
  $('#main').removeClass("grid_10 push_2");
  $('#main').addClass("grid_12 push_0");
  $('#show_sidebar_tab').show();
}

function show_sidebar(){
  $('#main').removeClass("grid_12 push_0");
  $('#main').addClass("grid_10 push_2");
  $('#show_sidebar_tab').hide();
}
