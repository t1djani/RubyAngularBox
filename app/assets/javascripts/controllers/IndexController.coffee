controllers = angular.module('controllers')

controllers.controller "IndexController", ($scope,$routeParams,$location,$resource, Recette) ->

    if $routeParams.keywords
      Recette.query keywords: $routeParams.keywords, ( data ) ->
        $scope.recettes = data.recettes
        $scope.pagination.totalItems = data.searchItem
    else
      $scope.recettes = []
      Recette.query ( data ) ->
        $scope.recettes = data.recettes
        $scope.pagination.totalItems = data.totalItem

    $scope.search = ( keywords )->  $location.path("/").search( 'keywords',keywords )
    $scope.newRecette = -> $location.path "/recettes/new"
    $scope.edit      = ( recetteId )-> $location.path "/recettes/#{ recetteId }/edit"

    $scope.pagination = {
      currentPage: 1
      perPage: 9
    }

    $scope.pageChanged = ->
      Recette.query( page: $scope.pagination.currentPage, (results)-> $scope.recettes = results.recettes )
