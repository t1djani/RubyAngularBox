controllers = angular.module('controllers',[])
controllers.controller("RecettesController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
    Recette = $resource('/recettes/:recetteId', { recetteId: "@id", format: 'json' })

    if $routeParams.keywords
       Recette.query(keywords: $routeParams.keywords, (results)-> $scope.recettes = results)
    else
      $scope.recettes = []

    $scope.view = (recetteId)-> $location.path("/recettes/#{recetteId}")
])
