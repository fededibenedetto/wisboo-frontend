$(window).bind "load resize", ->
  footer = $(".footer")
  pos = footer.position()
  height = $(window).height() - pos.top - footer.outerHeight()
  footer.css "margin-top": height + "px"  if height > 0
