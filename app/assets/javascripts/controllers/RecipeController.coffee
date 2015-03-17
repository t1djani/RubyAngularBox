controllers = angular.module('controllers')
controllers.controller("RecetteController", [ '$scope', '$routeParams', '$resource', '$location', 'flash',
  ($scope,$routeParams,$resource,$location, flash)->
    Recette = $resource('/recettes/:recetteId', { recetteId: "@id", format: 'json' })

    Recette.get({recetteId: $routeParams.recetteId},
      ( (recette)-> $scope.recette = recette ),
      ( (httpResponse)->
        $scope.recette = null
        flash.error   = "Il n'y a pas de recette avec cet ID: #{$routeParams.recetteId}"
      )
    )

    $scope.back = -> $location.path("/")
])
