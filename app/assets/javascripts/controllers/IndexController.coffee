controllers = angular.module('controllers')

controllers.controller "IndexController", ($scope,$routeParams,$location,$resource, Recettes) ->

    $scope.show = false

    if $routeParams.keywords
      Recettes.query keywords: $routeParams.keywords, ( data ) ->
        $scope.recettes = data.recettes
        $scope.pagination.totalItems = data.searchItem
    else
      $scope.recettes = Recettes.query ( data ) ->
        $scope.recettes = data.recettes
        $scope.pagination.totalItems = data.totalItem

    $scope.search = ( keywords )->  $location.path("/").search( 'keywords',keywords )
    $scope.newRecette = -> $location.path "/recettes/new"
    $scope.edit      = ( recetteId )-> $location.path "/recettes/#{ recetteId }/edit"

    $scope.pagination = {
      currentPage: 1
      perPage: 3
    }

    $scope.pageChanged = ->
      Recettes.query( page: $scope.pagination.currentPage, (results)-> $scope.recettes = results.recettes )
