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
//= require_tree .
//= require jquery


// $(document).ready(function() {
//   $(function(alert) {
//     $('.alert').observe( function() {
//       // Some complex code
//       //document.getElementById("notice").setAttribute("style", "display: block;");
//       M.toast({html: notice});
//       return false;
//     });
//   });
// });

//SCROLL TO & DISMISS FLASH MESSAGES
function topFunction() {
  document.body.scrollTop = 0;
  document.documentElement.scrollTop = 0;
}

$(document).ready(function() {
  setTimeout(function() {
    $('#flash').slideUp();
  }, 4000);
});


//MOBILE NAV INIT
document.addEventListener('DOMContentLoaded', function() {
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
  $("[id^='comment_'][id$='search_gif_submit']").on('click', function(event){
      event.preventDefault();

      $('img').remove('.giphy_gif');

      var input = event.originalEvent.path[2].childNodes[1].value;

      var xhr = $.get("http://api.giphy.com/v1/gifs/search?q=" + input + "&api_key=9A9x8hnTDvxuPLVhcP6YhG7IT5A0XMXj&limit=12/data/images/downsized");

      xhr.done(function(response) { console.log("success got data", response);

      var gifs = response.data;

      var giphyDivId = event.currentTarget.parentElement.parentElement.id;

      for(i in gifs){
        $('#' + giphyDivId).append("<img src='"+gifs[i].images.original.url+"'class='giphy_gif' style='height:100px; width:100px;'/>")
      }
    });
  });
});


//UNHIDE COMMENT GIF SEARCH
$(document).ready(function(){
  $("[id^='comment_'][id$='link_to_gif_reactions']").on('click', function(event) {
    event.preventDefault();

    var commentableDivId = event.currentTarget.id.match(/(\d)+/g);

    var giphyDivId = "commentable_" + commentableDivId[0] + "_giphy";

    $('#' + giphyDivId).toggle();
  });
});


//UNHIDE COMMENT REPLY
$(document).ready(function(){
  $("[id^='comment_'][id$='reply_link']").on('click', function(event) {
    event.preventDefault();
    var replyLinkId = event.currentTarget.id;
    var partialId = replyLinkId + "_partial";
    $('#' + partialId).toggle();
  });
});

//UNHIDE COMMENT
$(document).ready(function(){
  $("#post_comment_link").on('click', function(event){
    event.preventDefault();
    $('#post_comment_partial').toggle();
  })
})
