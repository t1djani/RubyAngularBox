controllers = angular.module('controllers')
controllers.controller("RecetteController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Recette = $resource('/recettes/:recetteId', { recetteId: "@id", format: 'json' },
      {
        'save': {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    if $routeParams.recetteId
      Recette.get({recetteId: $routeParams.recetteId},
        ( (recette)-> $scope.recette = recette ),
        ( (httpResponse)->
          $scope.recette = null
          flash.error   = "Il n'y a pas de recette avec l'ID: #{$routeParams.recipeId}"
        )
      )
    else
      $scope.recette = {}

    $scope.back   = -> $location.path("/recettes")
    $scope.edit   = -> $location.path("/recettes/#{$scope.recette.id}/edit")
    $scope.cancel = ->
      if $scope.recette.id
        $location.path("/recettes/#{$scope.recette.id}")
      else
        $location.path("/recettes")

    $scope.save = ->
      onError = (_httpResponse)-> flash.error = "Il y a une erreur"
      if $scope.recette.id
        $scope.recette.$save(
          ( ()-> $location.path("/recettes/#{$scope.recette.id}") ),
          onError)
      else
        Recette.create($scope.recette,
          ( (newRecette)-> $location.path("/recettes/#{newRecette.id}") ),
          onError
        )

    $scope.delete = ->
      $scope.recette.$delete()
      $scope.back()
])
