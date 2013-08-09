(function(){
  $(function(){
    $(".check_field").checker("keyup");

    $("#grid-content").vgrid({
      easing: "easeOutQuint",
      time: 500,
      delay: 20,
      feedIn: {
        time: 300,
        delay: 50
      }
    });
  });
})();