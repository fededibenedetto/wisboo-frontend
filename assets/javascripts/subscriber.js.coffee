$(document).ready ->
  $("#new_subscriber").on("ajax:success", (e, data, status, xhr) ->
    $(".subscribe-form").html "¡Te has suscripto exitosamente!"
  ).on "ajax:error", (e, data, status, xhr) ->
    errors = ""
    for i in jQuery.parseJSON(data.responseText).subscribers
      errors += "<li>" + i + "</li>"

    $(".subscribe-form .errors").html ("<ul>" + errors + "</ul>")
