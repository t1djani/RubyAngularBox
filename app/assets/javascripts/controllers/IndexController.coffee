controllers = angular.module('controllers')

controllers.controller "IndexController", ($scope,$routeParams,$location,$resource) ->

    # Recupérer les recettes en db via json
    Recette = $resource '/recettes/:recetteId', { recetteId: "@id", format: 'json' }
    Recettes = $resource '/recettes', { recettes: '@recettes', format: 'json' }
    $scope.show = false


    if $routeParams.keywords
      Recette.query(keywords: $routeParams.keywords, (results)-> $scope.recettes = results)
    else
      $scope.recettes = Recettes.query page: 2s

    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    $scope.newRecette = -> $location.path("/recettes/new")
    $scope.edit      = (recetteId)-> $location.path("/recettes/#{recetteId}/edit")

    console.log $scope.page

    $scope.willPaginateCollection =
      currentPage : $scope.page
      perPage : 2
      totalEntries : $scope.recettes.length
      totalPages : $scope.recettes.length / 2

    $scope.willPaginateConfig =
      previousLabel: 'Précédent'
      nextLabel: 'Suivant'

    $scope.getPage = (page) ->
      console.log page
