load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "ThreadCreateController", ["$scope", "$state", "$stateParams", "Thread", "Post",
   "fileReader", "$rootScope", "$http", "$controller"
  ($scope, $state, $stateParams, Thread, Post, fileReader, $rootScope, $http, $controller) ->
    $controller('ThreadFormController', {$scope: $scope})
    $scope.resetThread = ->
      $scope.request_sent = false
      $scope.thread = new Thread
      $scope.thread.original_post = new Post
    $scope.addThread = ->
      $scope.request_sent = true
      $scope.thread.$save( subforumId: $scope.subforumId )
      .then (new_thread)->
        # Reset image and cropper
        if $('#thread-image').length
          $('#thread-image').val('')
          $scope.imageSrc = ''
          if $('.cropper-hidden').length
            $('.cropper-hidden').cropper('destroy')
        $rootScope.$broadcast('threadAdded', new_thread)
        $('.js-new-post-form').collapse('hide')
        $scope.resetThread()
        $('html, body').animate { scrollTop: $(".js-scroll-after-post").offset().top }, 'slow'
        $scope.publish_error = false
        $scope.request_sent = false
      .catch ->
        $scope.publish_error = true
        $scope.request_sent = false
    $scope.imageCropModalId = 'image-crop-modal-create'
    $scope.resetThread()
  ]
