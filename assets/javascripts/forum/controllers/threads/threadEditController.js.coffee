load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "ThreadEditController", ["$scope", "$state", "$stateParams", "Thread", "$controller"
  ($scope, $state, $stateParams, Thread, $controller) ->
    $controller('ThreadFormController', {$scope: $scope})
    $scope.saveOldImages = (thread) ->
      $scope.old_image = thread.original_post.link.image if thread.original_post.link
      $scope.old_file = thread.original_post.media.file if thread.original_post.media
    $scope.removeUnchangedImages = ->
      if $scope.thread.original_post.link && $scope.old_image == $scope.thread.original_post.link.image
        delete $scope.thread.original_post.link
      if $scope.thread.original_post.media && $scope.old_file == $scope.thread.original_post.media.file
        delete $scope.thread.original_post.media
    $scope.updateThread = ->
      $scope.removeUnchangedImages()
      $scope.request_sent = true
      $scope.publish_error = false
      $scope.thread.$update(subforumId: $scope.subforumId)
      .then ->
        $scope.request_sent = false
        if $scope.template == 'discussions'
          $state.go 'viewThread', id: $scope.thread.id
        else
          $state.go 'threads'
      .catch ->
        $scope.publish_error = true
        $scope.request_sent = false
    $scope.loadThread = ->
      $scope.thread = Thread.get(subforumId: $scope.subforumId, id: $stateParams.id)
      $scope.thread.$promise.then (thread) ->
        $scope.saveOldImages(thread)
    $scope.imageCropModalId = 'image-crop-modal-edit'
    $scope.loadThread()
  ]
