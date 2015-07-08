load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive("wCropper", -> {
    restrict: 'A'
    link: (scope, element, attrs) ->
      imageWidth = 470;
      imageHeigt = 352;
      element.bind 'load', ->
        $(element).cropper('destroy')
        .cropper(
          minCropBoxWidth: imageWidth / 2
          minContainerHeight: imageHeigt / 2
        )
        .cropper('setDragMode', 'crop')
        .cropper('setAspectRatio', imageWidth / imageHeigt)
  })
