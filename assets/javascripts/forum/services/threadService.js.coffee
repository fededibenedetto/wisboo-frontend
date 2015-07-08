load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp.services')
  .factory 'Thread', ["$resource", ($resource) ->
    $resource '/sub_forums/:subforumId/threads/:id.json',
      subforumId: '@subForumId'
      id: '@id'
    ,
      update:
        method: 'PUT'
  ]
