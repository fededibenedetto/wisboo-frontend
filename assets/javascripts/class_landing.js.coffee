load "courses#show", (controller, action) ->
  $('[data-toggle="tooltip"]').tooltip()

  $("#video-modal").on "hidden.bs.modal", ->
    $("#video-modal iframe").attr('src', $("#video-modal iframe").attr('src'))
