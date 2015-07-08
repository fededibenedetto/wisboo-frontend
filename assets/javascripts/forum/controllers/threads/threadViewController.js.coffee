load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "ThreadViewController", ["$scope", "$state", "$stateParams", "$sce", "Thread",
  ($scope, $state, $stateParams, $sce, Thread) ->
    $scope.deleteThread = (thread) ->
      thread.$delete { subforumId: $scope.subforumId }, ->
        $state.go "threads"
    $scope.thread = Thread.get(subforumId: $scope.subforumId, id: $stateParams.id)
  ]
