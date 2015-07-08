load
  controllers:
    courses: ['show'],
    channels: ['index']
, (controller, action) ->
  collapsedLines = 5
  lineHeight = parseInt($('.read-more p').css('line-height'), 10)
  collapsedHeight =  lineHeight * collapsedLines;
  $(".read-more p").readmore
    collapsedHeight: collapsedHeight
    moreLink: "<a href=\"#\" class=\"small morelink\">" + I18n.t("courses.show.more") + "</a>"
    lessLink: "<a href=\"#\" class=\"small morelink\">" + I18n.t("courses.show.less") + "</a>"
