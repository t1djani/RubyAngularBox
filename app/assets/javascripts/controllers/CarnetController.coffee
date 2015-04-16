controllers = angular.module 'controllers'

controllers.controller "CarnetController", ($scope,$routeParams,$location,$resource,$modal, $log, Carnet, Auth, Recette) ->


  if $routeParams.id
    Carnet.get { id: $routeParams.id },
     (data) ->
      $scope.carnet = data.carnet
      $scope.carnet.recettes = data.recettes
      $scope.pagination.totalItems = data.totalItem

  $scope.pagination = {
    currentPage: 1
    perPage: 3
  }

  Auth.currentUser().then ( user ) ->
    $scope.user = user

  # Methodes

  $scope.carnetChanged = ->
    Recette.query page: $scope.pagination.currentPage,
      (results) ->
        $scope.carnet.recettes = results.recettes
