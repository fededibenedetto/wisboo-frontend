load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive('ngEnter', ->
    (scope, element, attrs) ->
      element.bind 'keydown keypress', (event) ->
        if event.which == 13
          scope.$apply ->
            scope.$eval attrs.ngEnter
          event.preventDefault()
  )
