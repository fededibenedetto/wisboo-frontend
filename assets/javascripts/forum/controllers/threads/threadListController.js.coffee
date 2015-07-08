load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "ThreadListController", ["$scope", "$state", "Thread", "subForum", "$filter"
  ($scope, $state, Thread, subForum, $filter) ->
    $scope.$watch 'threadsFilter.title', (tmpStr) ->
      $scope.getThreads() if tmpStr == $scope.threadsFilter.title
    $scope.getThreads = ->
      $scope.current_page = 1
      Thread.get({
          subforumId: $scope.subforumId,
          page: $scope.current_page,
          order: $scope.template,
          category: $scope.threadsFilter.category_id,
          title: $scope.threadsFilter.title }).$promise.then (result) ->
        $scope.threads = $.map(result.threads, (thread) -> new Thread(thread))
        $scope.count = result.meta.count
    $scope.seeMore = ->
      $scope.current_page++
      Thread.get({
        subforumId: $scope.subforumId,
        page: $scope.current_page,
        order: $scope.template,
        category: $scope.threadsFilter.category_id },
        (result) ->
          result.threads = $.map(result.threads, (thread) -> new Thread(thread))
          Array.prototype.push.apply($scope.threads, result.threads)
          $scope.count = result.meta.count
      )
    $scope.changeCategory = (category_id) ->
      $scope.threadsFilter.category_id = category_id
      $scope.getThreads()
    $scope.clearCategory = ->
      delete $scope.threadsFilter.category_id
      $scope.getThreads()
    $scope.categoryClass = (category_id) ->
      'category-selected' if (category_id == $scope.threadsFilter.category_id)
    $scope.$on 'threadAdded', (event, thread) ->
      $scope.threads.unshift(thread)
      $scope.count++
    $scope.deleteThread = (thread, index) ->
      thread.$delete { subforumId: $scope.subforumId }, ->
        $scope.threads.splice(index, 1)
        $scope.count--
    $scope.noThreads = ->
      $scope.threads && $scope.threads.length == 0;
    $scope.threadsFilter = {}
    subForum.categories($scope.subforumId).then (response) ->
      $scope.categories = response.data
    $scope.clearCategory()
    $scope.getThreads()
  ]
