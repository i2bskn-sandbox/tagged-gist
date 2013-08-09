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
//= require bootstrap.min
//= require jquery.checker
//= require jquery.easing.1.3
//= require jquery.vgrid.min
//= require_tree .

(function(){
  $(function(){
    $("#sync_button").on("click", function(){
      $("#sync_icon").empty();
      var loading_icon = $("<img>").attr("src", "/img/sync.gif");
      $("#sync_icon").append(loading_icon);

      $.ajax({
        type: 'GET',
        url: '/gists/sync',
        success: function(data){
          if (data.status === "success"){
            location.reload();
          } else {
            alert(data.status);
          };
        }
      });
    });
  });
})();