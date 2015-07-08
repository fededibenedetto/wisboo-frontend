load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .filter("translate", ->
    (input) ->
      I18n.t('forum_app.' + input)
  )
