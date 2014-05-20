// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require foundation
//= require_tree .



function initialise() {
  var mapOptions = {
    center: new google.maps.LatLng(51.5, -0.1),
    zoom: 14,
    streetViewControl: false,
    mapTypeControl: false
  };
  var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
  addMarker(map);
};


function addMarker(map) {
  console.log("Showing marker from geocoder results.");
  var geocoder = new google.maps.Geocoder();
  var showMarkerFromGeocoderResults = function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      var marker = new google.maps.Marker({
          position: results[0].geometry.location,
          map: map
      });
      map.setCenter(results[0].geometry.location);
    } else {
      console.warn("could not geocode address.");
    }
  }
  $('address').each(function(i, el) {
    var geocoderOptions = { address: $(el).text() };
    geocoder.geocode(geocoderOptions, showMarkerFromGeocoderResults);
  });
}

google.maps.event.addDomListener(window, 'load', initialise);


$(function() {
  $(document).foundation();


  $( "#tabs" ).tabs({
    });

  $('#search').on('click', function() {
    $('#search_form').submit();
  });
});
