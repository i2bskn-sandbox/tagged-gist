(function($){
  $.fn.checker = function(event){
    var tag_name;

    $(this).on(event, function(){
      tag_name = $(this).val();

      if (tag_name.length > 0 && tag_name.length < 21) {
        $(this).parent("div").children(".submit_button").removeAttr("disabled");
      } else {
        $(this).parent("div").children(".submit_button").attr("disabled", "disabled");
      };
    });
  };
})(jQuery);
