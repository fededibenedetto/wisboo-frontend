load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive("bsPopover", ->
    (scope, element, attrs) ->
      if $(element).attr("bs-inactive") != 'true'
        element.popover()
  )
  .directive("bsPopoverHtml", ->
    (scope, element, attrs) ->
      element.popover
        html: true
        content: ->
          $($(element).data("content-id")).html()
  )
