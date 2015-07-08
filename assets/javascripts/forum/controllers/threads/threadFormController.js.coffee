load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "ThreadFormController",
  ["$scope", "$state", "$stateParams", "Thread",
   "Post", "fileReader", "$rootScope", "$http", "subForum"
  ($scope, $state, $stateParams, Thread, Post, fileReader, $rootScope, $http, subForum) ->
    subForum.categories($scope.subforumId).then (response) ->
      $scope.categories = response.data
    $scope.showCategories = ->
      $scope.categories && $scope.categories.length > 0
    $scope.clearUrl = ->
      $scope.thread.original_post.link = {}
    $scope.deleteUrl = ->
      delete $scope.thread.original_post.link
    $scope.getUrlMetadata = ->
      return if !$scope.thread.original_post.link
      $scope.retrievingMetadata = true
      post_url = $scope.thread.original_post.link.url
      $http(
        url: '/sub_forums/url_meta'
        method: 'GET'
        params: { url: post_url }
      ).success((data) ->
        $scope.thread.original_post.link = data
        $scope.linkError = ""
        $scope.retrievingMetadata = false
      ).error (data) ->
        $scope.clearUrl()
        $scope.linkError = data.message
        $scope.retrievingMetadata = false
    $scope.deleteImage = ->
      delete $scope.thread.original_post.media
    $scope.cropImage = ->
      $('.image-crop-modal').modal('hide')
      croppedImage = $('.js-cropper').cropper('getDataURL')
      $scope.thread.original_post.media = file: croppedImage if croppedImage
    $scope.getFile = (file) ->
      fileReader.readAsDataUrl(file, $scope).then (result) ->
        $scope.imageSrc = result
  ]
