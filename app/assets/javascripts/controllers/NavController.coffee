controllers = angular.module 'controllers'

controllers.controller "NavController", ($scope, Auth,$location) ->

  # Expose the method to $scope
  $scope.signedIn = Auth.isAuthenticated
  $scope.logout = Auth.logout

  Auth.currentUser().then ( user ) ->
    $scope.user = user

  $scope.$on 'devise:new-registration', (e, user) ->
    $scope.user = user

  $scope.$on 'devise:login', (e, user) ->
    $scope.user = user

  $scope.$on 'devise:logout', (e, user) ->
    $scope.user = {}

  $scope.index = (userId) -> $location.path "/users/#{userId}"
