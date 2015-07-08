load
  controllers:
    channels: ['index'],
    units:    ['show']
, (controller, action) ->
  angular.module("forumApp.controllers")
  .controller "PostsController" , ["$scope", "$state", "$stateParams", "Post",
  ($scope, $state, $stateParams, Post) ->
    $scope.deletePost = (post, index) ->
      post.$delete { subforumId: $scope.subforumId, threadId: $scope.thread.id }, ->
        $scope.posts.splice(index, 1)
        $scope.thread.answers_count--
    $scope.loadPosts = ->
      $scope.posts = Post.query(subforumId: $scope.subforumId, threadId: $scope.thread.id)
      $scope.post = new Post(subforumId: $scope.subforumId, threadId: $scope.thread.id)
      $scope.current_page = 1
      $scope.collapsePosts = ->
        $scope.current_page = 1
        $scope.posts = $scope.posts.slice(0, 3)
      $scope.seePreviousPosts = ->
        $scope.current_page++
        Post.query({
          subforumId: $scope.subforumId,
          threadId: $scope.thread.id,
          page: $scope.current_page },
          (previous_posts) ->
            Array.prototype.push.apply($scope.posts, previous_posts)
        )
    $scope.updatePostBody = (post, new_body) ->
      post.$update
        subforumId: $scope.subforumId
        threadId: $scope.thread.id
        body: new_body
      .then ->
        return true
      .catch ->
        return I18n.t('forum_app.' + $scope.template + '.error_comment')
    $scope.addPost = ->
      $scope.post.$save().then((post) ->
        $scope.posts.push(post)
        $scope.post = new Post(subforumId: $scope.subforumId, threadId: $scope.thread.id)
        $scope.thread.comment_error = false
        $scope.thread.answers_count++
      ).catch((response) ->
        if response.status == 401
          $scope.thread.can_post = false
        else
          $scope.thread.comment_error = true
      )
    if $scope.thread.$promise
      $scope.thread.$promise.then ->
        $scope.loadPosts()
    else
      $scope.loadPosts()
  ]
