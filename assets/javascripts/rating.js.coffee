load
  controllers:
    units: ["show"],
    courses: ["show"]
, (controller, action) ->
  $("#raty").raty
    score: 0
    hints: null
    click: (score, evt) ->
      $("#hidden-rating").val score.toString()
  val=$("#rating-course").data('rating')
  $("#rating-course").raty
    readOnly: true
    score: val
    noRatedMsg : ""
