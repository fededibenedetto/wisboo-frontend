load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp').config(["$stateProvider", ($stateProvider) ->
    templateFolder = 'forum/' + $('.forums').data('template') + '/threads/'
    $stateProvider
    .state('threads',
      url: '/threads'
      templateUrl: templateFolder + 'index.html'
      controller: 'ThreadListController'
    )
    .state('viewThread',
      url: '/threads/:id/view'
      templateUrl:  templateFolder + 'show.html'
      controller: 'ThreadViewController'
    )
    .state('newThread',
      url: '/threads/new'
      templateUrl: templateFolder + 'new.html'
      controller: 'ThreadCreateController'
    )
    .state 'editThread',
      url: '/threads/:id/edit'
      templateUrl: templateFolder + 'edit.html'
      controller: 'ThreadEditController'
  ])
