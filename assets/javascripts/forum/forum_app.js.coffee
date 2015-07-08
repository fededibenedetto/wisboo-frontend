load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp', ['ui.router', 'ngResource', 'forumApp.controllers',
                              'forumApp.services', 'templates', 'ngSanitize',
                              'angularMoment', 'ui.bootstrap', 'xeditable']
  )
  angular.module('forumApp.controllers', [])
  angular.module('forumApp.services', [])
  .config(["$httpProvider", ($httpProvider) ->
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
  ])
  .run ["$state", "amMoment", "$rootScope", ($state, amMoment, $rootScope) ->
    $state.go('threads')
    amMoment.changeLocale $('html').attr('lang');
    $rootScope.template = $('.forums').data('template')
    $rootScope.templateFolder = 'forum/' + $rootScope.template + '/threads/'
    $rootScope.commonFolder = 'forum/common/threads/'
    $rootScope.canCreate = $('.forums').data('can-create') == ""
  ]

  $(document).ready ->
    angular.bootstrap($('.forums'), ['forumApp']);
