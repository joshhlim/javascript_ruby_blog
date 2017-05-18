$(document).ready(function() {
  console.log("ready")

  $("a#new-post").click(function(e) {
    e.preventDefault();
    $("form#post").show();
  })

  $("form#post").submit(function(e) {
    debugger
    e.preventDefault();
    var input = $(this).serialize();
    $.ajax({
      method: "POST",
      url: "/entries",
      data: input
    })
    .done(function(response) {
      console.log(response)
      $("ul.entries-list").append(response);
      $("form#post").hide();
    })
  })
});
