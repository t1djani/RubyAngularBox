controllers = angular.module 'controllers'

controllers.controller "AuthController", ( $scope,$routeParams,$location,$resource,Auth,User ) ->

  Auth.currentUser().then ( user ) ->
    $scope.user = user

  $scope.login = ->
    Auth.login($scope.user).then ->
      $location.path '/'

  $scope.register = ->
    Auth.register($scope.user).then ->
      $location.path '/'
