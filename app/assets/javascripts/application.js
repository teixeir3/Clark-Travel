// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require gallery/responsive
//= require gallery/slideshow
//= require gallery/galleria
//= require gallery/galleria/classic
//= require gallery/touch_touch
//= require jquery/jquery.easing-1.3
//= require jquery/jquery.elastislide
//= require jquery/jquery.tmpl.min
//= require_tree .
//= require jquery-ui
//= require owl.carousel

var fadeOutElement = function($el, delay) {
  window.setTimeout(function() {
    $el.fadeOut();
  }, delay);
};

$(document).on('page:change', function() {
  console.log("page:change trigger.");
 
  $('body').prepend('<div id="fb-root"></div>');

  $.ajax({
    url: "#{window.location.protocol}//connect.facebook.net/en_US/all.js",
    dataType: 'script',
    cache: true
  });
 
  fadeOutElement($('.errors'), 6000);
  fadeOutElement($('.notices'), 6000);
  
  var owl = $('.owl-carousel');
  var owl2 = $('.testimonials-carousel');
  
  owl.owlCarousel({
     items : 1, 
     itemsDesktop : false,
     itemsDesktopSmall : false,
     itemsTablet: false,
     itemsMobile : false,
     loop: true,
     margin: 0,
     autoplay: true,
     autoplaySpeed: true,
     autoplayHoverPause: true
  });
  owl.trigger('owl.play',5000);
  
  owl2.owlCarousel({
    items : 1, 
    itemsDesktop : false,
    itemsDesktopSmall : false,
    itemsTablet: false,
    itemsMobile : false,
    loop: true,
    margin: 0,
    autoplay: true,
    autoplaySpeed: true,
    autoplayHoverPause: true,
    dots: false,
    pagination: false
  });
  owl2.trigger('owl.play', 4000);
  
  $('#users').sortable({
    update: function(event, ui) {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
    }
  });
 
  $('.logins').on('mouseenter', function() {
    console.log(".logins: hover triggered");
    $('.logout').removeClass("hidden");
  });
  
  $('.logins').on('mouseleave', function() {
    console.log(".logins: hover triggered");
    $('.logout').addClass("hidden");
  });
});

//Define variables.
var _holdPromotion=false;
var _promotion=0;
var _promotions=new Array();



/***************************************************************************
	Track mouse movement over the active promotion.
***************************************************************************/
function holdPromotion(holdPromotion){
	_holdPromotion=holdPromotion;
}

/***************************************************************************
	Load the current promotion.
***************************************************************************/
function loadPromotion(){
	if(_promotions.length==0)
		return false;
	
	//Load the current promotion.
	document.getElementById("promotion").src="promotion/photo.php?id="+_promotions[_promotion];
	document.getElementById("promotion").onclick=function(){
		window.location="promotion.php?id="+_promotions[_promotion];
	};
}

/***************************************************************************
	Advance to the next promotion.
***************************************************************************/
function nextPromotion(){
	if(_promotion==_promotions.length-1)
		_promotion=0;
	else
		_promotion++;
	loadPromotion();
}

/***************************************************************************
	Return to the previous promotion.
***************************************************************************/
function previousPromotion(){
	if(_promotion==0)
		_promotion=_promotions.length-1;
	else
		_promotion--;
	loadPromotion();
}

/***************************************************************************
	Move to the next promotion if the current promotion is not active.
***************************************************************************/
function rotatePromotions(){
	if(!_holdPromotion)
		nextPromotion();
}