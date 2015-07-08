load 'channels#index', (controller, action) ->
  channelCoursesAnimations = angular.module('channelCoursesAnimations', ['ngAnimate'])

  channelCourses = angular.module('channelCourses', ['channelCoursesAnimations'])

  channelCourses.directive "bsTooltip", ->
    (scope, element, attrs) ->
      element.tooltip()

  channelCourses.controller 'CourseListController', [ '$scope', '$http', '$filter', ($scope, $http, $filter) ->
    $scope.courses = []
    $scope.requestError = false

    pagesShown = 1
    pageSize = 4

    $scope.paginationLimit = (data) ->
      pageSize * pagesShown

    $scope.hasMoreItemsToShow = (query = '') ->
      pagesShown < ($scope.courses.length / pageSize) && $filter('filter')($scope.courses, query).length > pageSize

    $scope.showMoreItems = ->
      pagesShown = pagesShown + 1

    $http.get('courses.json').success (data) ->
      $scope.courses = data

      $scope.noCourses = ->
        $scope.courses.length == 0;
    .error () ->
      $scope.requestError = true
   ]

  channelCourses.controller 'ThematicsListController', [ '$scope', '$http', ($scope, $http) ->
    $http.get('thematics.json').success (data) ->
      $scope.thematics = data
   ]
