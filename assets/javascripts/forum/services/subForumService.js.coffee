load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp.services')
  .factory 'subForum', ["$http", ($http) ->
      subForum = {}
      subForum.categories = (id) ->
        $http.get('/sub_forums/' + id + '/categories')
      subForum
  ]
