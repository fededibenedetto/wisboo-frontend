load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module('forumApp')
  .directive 'ngFileSelect', -> {
    link: ($scope, element) ->
      element.bind 'change', (e) ->
        $scope.file = (e.srcElement or e.target).files[0]
        $scope.getFile($scope.file)
  }
