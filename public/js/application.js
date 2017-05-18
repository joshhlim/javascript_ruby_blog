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
      url: $(this).attr("action"),
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
// window.item = $item
  $('body').on('click', 'a.edit', function(e){
    e.preventDefault()
    var $item = $(this).closest('li.entry-item')
    console.log($(this).attr('href'))
      $.ajax({
        method: "GET",
        url: $(this).attr('href')
        })
        .done(function(response){
          $item.append(response)
        })
    //    console.log($(this).children().eq(0).attr('href'))
    // $('form#new').append('<input type="hidden" name="_method" value="put">')
    //      $item.css("background", "green")
    //   $('form#new').show().find("#title-input").val("Edit Title")
    //   $('#body-textarea').val("Edit Body")
    // var data = $('form#new').serialize()
    // $.ajax({
    //   method: "PUT",
    //   url: $item.find('a').attr('href'),
    //   data: data
    //  })
    //   .done(function(response) {
    //     $('.entries-list').remove($item).append(response)
    //     $('form#new').trigger("reset").hide()
    //   })
  })

  $('body').on('submit', 'form.update', function(e){
    e.preventDefault()
    var $entry = $(this).closest('.entry-item')
      $.ajax({
        method: "PUT",
        url: $(this).attr('action'),
        data: $(this).serialize()
        })
        .done(function(response){
          console.log(response)
          $('h1.edit').remove()
          $('.update').remove()
          $entry.remove()
          $('.entries-list').append(response)
        })
  })

  $("form.new_user").submit(function(event) {
    event.preventDefault()
      var name = $(this).find("input#name").val()
      var email = $(this).find("input#email").val()
      var password = $(this).find("input#password").val()
      var nameRegex = /^[a-zA-Z\-]+$/
      var emailRegex = /^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$/
      var passwordRegex = /^(?=.{8,})(?=.*[A-Z])(?=.*[0-9])/
      var errorMessages = "<li>Must be a real name</li><li>Must be a valid & unique email address</li><li>Password must have at least one number</li><li>Password must have at least one capital letter</li><li>Password must be at least 8 characters long</li>"
      var data = $(this).serialize()
      console.log($(this).attr('action'))
    if (nameRegex.test(name) && emailRegex.test(email) && passwordRegex.test(password)) {
      $.ajax({
        method: "POST",
        url: $(this).attr('action'),
        data: data,
        dataType: "json"
        })
          .done(function(response) {
            alert("Welcome, " + response.name + " of " + response.email)
            window.location = "/"
          })
    } else {
      $(this).append(errorMessages)
    }
  })
});
