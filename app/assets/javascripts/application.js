// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery


$(document).ready(function() {
  $(function(alert) {
    $('.alert').observe( function() {
      // Some complex code
      //document.getElementById("notice").setAttribute("style", "display: block;");
      M.toast({html: notice});
      return false;
    });
  });
});


//MOBILE NAV INIT
document.addEventListener('turbolinks:load', function() {
  var elems = document.querySelectorAll('.sidenav');
  var instances = M.Sidenav.init(elems);
});

// $(document).ready(function(){
//   $(document).addEventListener('turbolinks:load', function() {
//     $('.sidenav').sidenav();
//   });
// });


//RETRIEVE GIFS
$(document).ready(function(){
  $('#search_gif_submit').on('click', function(event){
      event.preventDefault();

      $('img').remove('.giphy_gif');

      var input = $('#gif_search_text').val();

      var xhr = $.get("http://api.giphy.com/v1/gifs/search?q=" + input + "&api_key=9A9x8hnTDvxuPLVhcP6YhG7IT5A0XMXj&limit=12");

      xhr.done(function(response) { console.log("success got data", response);

      var gifs = response.data;

      for(i in gifs){
        $('.giphy').append("<img src='"+gifs[i].images.original.url+"'class='giphy_gif' style='height:100px; width:100px;'/>")
      }
    });
  });
});


//UNHIDE COMMENT GIF SEARCH
$(document).ready(function(){
  $('.link_to_gif_reactions').on('click', function(event) {
    event.preventDefault();
    $('.giphy').toggle();
  });
});
