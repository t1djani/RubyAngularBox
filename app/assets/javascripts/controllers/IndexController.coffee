controllers = angular.module('controllers')

controllers.controller "IndexController", ($scope,$routeParams,$location,$resource) ->

    # Recupérer les recettes en db via json
    Recette = $resource '/recettes/:recetteId', { recetteId: "@id", format: 'json' }
    Recettes = $resource '/recettes', { recettes: '@recettes', format: 'json' }

    $scope.show = false

    if $routeParams.keywords
      Recette.query(keywords: $routeParams.keywords, (results)-> $scope.recettes = results)
    else
      $scope.recettes = Recettes.query()

    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    $scope.newRecette = -> $location.path "/recettes/new"
    $scope.edit      = (recetteId)-> $location.path "/recettes/#{recetteId}/edit"

    $scope.pagination = {
      currentPage: 1
      perPage: 2
    }

    Recette.query keywords: "", (results) ->
      $scope.pagination.totalItems = results.length

    $scope.pageChanged = ->
      Recettes.query(page: $scope.pagination.currentPage, (results)-> $scope.recettes = results)
