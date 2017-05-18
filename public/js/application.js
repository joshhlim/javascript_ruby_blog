$(document).ready(function() {
  $('form#new').hide()

  $('a.block').click(function(e) {
    e.preventDefault()
    $('form#new').show()
  })

  $('form#new').submit(function(e){
    e.preventDefault()
    var data = $('form#new').serialize()
    $.ajax({
      method: "POST",
      url: $('form#new').attr('action'),
      data: data
    })
      .done(function(response) {
        $('.entries-list').append(response)
        $('form#new').trigger("reset").hide()
      })
  })

  $('body').on('submit', 'form.delete', function(e){
    e.preventDefault()
    var $item = $(this).closest('li.entry-item')
    $.ajax({
      method: "DELETE",
      url: $(this).attr("action")
    })
      .done(function(response) {
        alert(response)
        $item.remove()
      })
  })

});
