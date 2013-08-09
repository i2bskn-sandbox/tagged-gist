(function(){
  $(function(){
    var vg = $("#grid-content").vgrid({
      easing: "easeOutQuint",
      time: 500,
      delay: 20,
      feedIn: {
        time: 300,
        delay: 50
      }
    });

    $(".check_field").checker("keyup");

    $(".tagged-visible").on("click", function(){
      $(this).css("display", "none");
      $(this).parent("li").children("div.tagged").css("display", "block");
      vg.vgrefresh();
    });

    $(".tagged-hide").on("click", function(){
      $(this).parents(".tagged").css("display", "none");
      $(this).parents("li").children("a.tagged-visible").css("display", "inline");
      vg.vgrefresh();
    });

    $("#filter").on("change", function(){
      var filter = $(this).val();
      switch (filter) {
        case "all":
          $("li.gist").each(function(){
            $(this).show();
          });
          break;
        case "public":
          $("li.private").each(function(){
            $(this).hide();
          });
          $("li.public").each(function(){
            $(this).show();
          })
          break;
        case "private":
          $("li.public").each(function(){
            $(this).hide();
          });
          $("li.private").each(function(){
            $(this).show();
          });
          break;
      };

      vg.vgrefresh();
    });
  });
})();