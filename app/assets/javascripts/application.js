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

//= require jquery/jquery.easing-1.3
//= require jquery/jquery.elastislide
//= require jquery/jquery.tmpl.min
//= require_tree .
//= require bootstrap-sprockets
//= require bootstrap
//= require jquery-ui
//= require owl.carousel
//= require jquery

var fadeOutElement = function($el, delay) {
  window.setTimeout(function() {
    $el.fadeOut();
  }, delay);
};

var rowFadeout = function() {
  console.log("in rowFadeout Method!");
  $(this).closest('tr').fadeOut();
};

var confirmDestroy = function(element, action) {
  if (confirm("Are you sure?")) {
    var f = document.createElement('form');
    f.style.display = 'none';
    element.parentNode.appendChild(f);
    f.method = 'POST';
    f.action = action;
    var m = document.createElement('input');
    m.setAttribute('type', 'hidden');
    m.setAttribute('name', '_method');
    m.setAttribute('value', 'delete');
    f.appendChild(m);
    f.submit();
  }
  return false;
}

var updateSortable = function(event, ui) {
      $.post($(this).data('update-url'), $(this).sortable('serialize'));
};


var refreshImage = function(cssClass){
  $.each($(cssClass), function(i, el) {
    var $el = $(el);
    $el.css("background-image", "url(" + $el.find("img").attr("src") + ")");
  });
};

var ready;
ready = function() {

  $('.delete-button').bind('ajax:success', function(evt, data, status, xhr){
    console.log("Great SUCCESS!!");
    console.log(evt);
    console.log(data);
    console.log(status);
    console.log(xhr);
  })

  $(".dropdown-toggle").dropdown();

  fadeOutElement($('.errors'), 6000);
  fadeOutElement($('.notices'), 6000);

  var owlPromotions = $('.promotions-carousel');
  var owlTestimonials = $('.testimonials-carousel');
  var owlFeed = $('.feed-carousel');
  var owlBookings = $('.bookings-carousel');

  owlPromotions.owlCarousel({
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
  owlPromotions.trigger('owl.play',10000);

  owlTestimonials.owlCarousel({
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

  owlTestimonials.trigger('owl.play', 10000);

  owlFeed.owlCarousel({
    items : 1, 
    itemsDesktop : false,
    itemsDesktopSmall : false,
    itemsTablet: false,
    itemsMobile : false,
    loop: true,
    margin: 0,
    autoplay: false,
    autoplaySpeed: true,
    autoplayHoverPause: true,
    dots: false,
    pagination: false
  });
  owlFeed.trigger('owl.play', 10000);

  owlBookings.owlCarousel({
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
  console.log("DID IT!");
  owlBookings.trigger('owl.play',7000);

  $('.sortable').sortable({
    update: updateSortable
  });

};

$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:change', ready);