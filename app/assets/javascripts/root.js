(function(){
  var tagging = function(field){
    var tag_name = field.find(".name").val();
    var gist_id = field.find(".gist_id").val();

    $.ajax({
      type: "POST",
      url: "/gists/tagged",
      dataType: "json",
      data: {"name": tag_name, "gist_id": gist_id},
      success: function(data){
        if (data.status === "Success"){
          location.reload();
        } else {
          alert(data.status);
        };
      }
    });
  };

  var untagging = function(field){
    var tag_name = field.find(".name").val();
    var gist_id = field.find(".gist_id").val();

    $.ajax({
      type: "POST",
      url: "/gists/untagged",
      dataType: "json",
      data: {"_method": "delete", "name": tag_name, "gist_id": gist_id},
      success: function(data){
        if (data.status === "Success"){
          location.reload();
        } else {
          alert(data.status);
        };
      }
    });
  };

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
      var field = $(this).parent("li").children("div.tagged");
      $(this).css("display", "none");
      field.css("display", "block");
      field.find(".name").focus();
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
          });
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

    $(".tagged_button").on("click", function(){
      var field = $(this).parents("div.tagged");
      tagging(field);
    });

    $(".untagged_button").on("click", function(){
      var field = $(this).parents("div.untagged");
      untagging(field);
    });

    $("input[type='text']").keypress(function(e){
      if ((e.which && e.which === 13) || (e.keyCode && e.keyCode === 13)){
        var field = $(this).parents("div.tagged");
        tagging(field);
        return false;
      } else {
        return true;
      };
    });
  });
})();