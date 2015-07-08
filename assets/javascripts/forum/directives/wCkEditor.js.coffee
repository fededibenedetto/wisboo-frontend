load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive("wCkEditor", ->
    (scope, element, attrs) ->
      CKEDITOR.replace('post_body')
  )
