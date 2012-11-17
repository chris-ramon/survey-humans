
$(document).ready(function() {
    $("body").css("display", "none");
 
    $("body").fadeIn(1000);
 
    $("a.transition").click(function(event){
        event.preventDefault();
        linkLocation = this.href;
        $("body").fadeOut(800, redirectPage);
    });
 
    function redirectPage() {
        window.location = linkLocation;
    }
});
///



///

function muestraMenu(){
	if ($('#popOverMenu').css('display') == "none"){
		$('#popOverMenu').show('slow');
	}
	else{
		$('#popOverMenu').hide('slow');
	}	
}
function muestraCaja(){

	if ($('#caja').css('display') == "none"){

		$('#caja').show('slow');
	}
	else{
		$('#caja').hide('fast');
	}	
}

function muestraButton(){
		$('#menuButton').show('slow');
}

function ocultaButton(){
		$('#menuButton').hide('slow');	
}

$(window).resize(function() {	
	$('#popOverMenu').hide('fast');
});


$(function(){
 
    // Set Inital orientation
    // get the initial orientation from window which
    // returns 0 for portrait and 1 for landscape
    if(window.orientation == 0){
        var ori = "portrait";
    }else{
        var ori = "landscape";
    }
    changeOrientation(ori);
 
    // Orientation Change
    // When orientation changes event is triggered
    // exposing an orientation property of either
    // landscape or portrait
    $('body').bind('orientationchange',function(event){
        changeOrientation(event.orientation)
    })
 
    // Change the style dependengt on orientation
    function changeOrientation(ori){
        // Remove all classes separated by spaces
	var orientation = window.orientation;
  	switch(orientation) {
	    case 0:		
		//alert("portup");
		hide_sidebar_pop();
		muestraButton();
		break;        
	    case 90:        
		//alert("landleft");      
		show_sidebar_pop();
		ocultaButton();
		break;   
	    case -90:         
		//alert("landright");        
		show_sidebar_pop();
		ocultaButton();
		break;
	    case 180:         
		//alert("portdown");        
		hide_sidebar_pop();
		muestraButton();
		break;
	  }
    }
})

function hide_sidebar_pop(){
  $('#show_sidebar_tab').hide();
  $('#main').removeClass("grid_10 push_2");
  $('#main').addClass("grid_12 push_0");
}

function show_sidebar_pop(){
  $('#main').removeClass("grid_12 push_0");
  $('#main').addClass("grid_10 push_2");
  $('#show_sidebar_tab').hide();
}


//<li class="current" id="menuButton"><a onclick="muestraMenu();" >Menu</a></li>
//FUncion para agregar un elemento a la lista
/*
function agregarButton(){
   var html="<li class=\"current\" id=\"menuButton\"><a onclick=\"muestraMenu();\" >Menu</a></li>";
   $('#mainmenu').append(html);
}
function quitarButton(){
   document.getElementById("menuButton").innerHTML="";
}
*/




 

