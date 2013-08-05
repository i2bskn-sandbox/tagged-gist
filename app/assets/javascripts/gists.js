(function(){
  $(function(){
    $(".untagged_button").on("click", function(){
      var field = $(this).parent("div.untagged");
      var tag_name = field.children(".name").val();
      var gist_id = field.children(".gist_id").val();

      $.ajax({
        type: 'POST',
        url: '/gists/untagged',
        dataType: 'json',
        data: {'_method': 'delete', 'name': tag_name, 'gist_id': gist_id},
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