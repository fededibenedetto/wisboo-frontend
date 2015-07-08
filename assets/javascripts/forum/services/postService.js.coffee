load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp.services')
  .factory('Post', ["$resource", ($resource) ->
    $resource '/sub_forums/:subforumId/threads/:threadId/posts/:id.json',
      subforumId: '@subforumId'
      threadId: '@threadId'
      id: '@id'
    ,
      update:
        method: 'PUT'
  ])
