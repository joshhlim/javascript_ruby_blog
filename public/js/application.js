$(document).ready(function() {
  $("a#new-post").click(function(e) {
    e.preventDefault();
    $("form#post").show();
  })

  $("form#post").submit(function(e) {
    e.preventDefault();
    var input = $(this).serialize();
    $.ajax({
      method: "POST",
      url: "/entries",
      data: input
    })
    .done(function(response) {
      $("form#post").hide();
      $("ul.entries-list").append(response);
    })
  })
});
