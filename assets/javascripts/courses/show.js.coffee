load "courses#show", ->
	$("span.applaud").click ->
	  $(this).toggleClass "clicked"
	  return

	$("span.recommend").click ->
	  $(this).toggleClass "clicked"
	  return

  if $('#pop-up-text').text()
    $('#pop-up').modal()
