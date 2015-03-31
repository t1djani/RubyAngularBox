controllers = angular.module('controllers')

controllers.controller "IndexController", ($scope,$routeParams,$location,$resource) ->

    # Recupérer les recettes en db via json
    Recette = $resource '/recettes/:recetteId', { recetteId: "@id", format: 'json' }
    Recettes = $resource '/recettes', { recettes: '@recettes', format: 'json' }

    if $routeParams.keywords
       Recette.query(keywords: $routeParams.keywords, (results)-> $scope.recettes = results)
    else
      $scope.recettes = Recettes.query()

    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    $scope.view = (recetteId)-> $location.path("/recettes/#{recetteId}")
    $scope.newRecette = -> $location.path("/recettes/new")
    $scope.edit      = (recetteId)-> $location.path("/recettes/#{recetteId}/edit")
