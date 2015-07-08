load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive 'httpPrefix', -> {
    restrict: 'A'
    require: 'ngModel'
    link: (scope, element, attrs, controller) ->

      ensureHttpPrefix = (value) ->
        if value and !/^(https?):\/\//i.test(value) and
           'http://'.indexOf(value) == -1 and 'https://'.indexOf(value) == -1
          controller.$setViewValue 'http://' + value
          controller.$render()
          'http://' + value
        else
          value

      controller.$formatters.push ensureHttpPrefix
      controller.$parsers.push ensureHttpPrefix
      return
  }
