load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive "wReadMore", -> {
    restrict: 'A'
    priority: 10
    link: (scope, element, attrs) ->
      scope.$watch attrs.ngBindHtml, ->
        p = $(element).find('p')
        collapsedLines = attrs.wReadMore
        lineHeight = parseInt(p.css('line-height'), 10)
        collapsedHeight = lineHeight * collapsedLines;
        $(p).readmore
          collapsedHeight: collapsedHeight
          heightMargin: lineHeight
          moreLink: "<a href=\"#\" class=\"small morelink\">" + I18n.t("courses.show.more") + "</a>"
          lessLink: "<a href=\"#\" class=\"small morelink\">" + I18n.t("courses.show.less") + "</a>"
  }
