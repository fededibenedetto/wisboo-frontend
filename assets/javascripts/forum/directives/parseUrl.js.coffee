load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive('parseUrl', ->
    urlPattern = /(http|ftp|https):\/\/[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])?/gi
    {
      restrict: 'A'
      require: 'ngModel'
      replace: true
      scope:
        props: '=parseUrl'
        ngModel: '=ngModel'
      link: (scope, element, attrs, controller) ->
        scope.$watch 'ngModel', (value) ->
          html = value.replace(urlPattern, '<a target="' + scope.props.target + '" href="$&">$&</a>')
          element.html html
  })
