(function(){
  $(function(){
    $(".tagged_button").on("click", function(){
      var field = $(this).parents("div.tagged");
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
      })
    });

    $(".untagged_button").on("click", function(){
      var field = $(this).parents("div.untagged");
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
    });
  });
})();