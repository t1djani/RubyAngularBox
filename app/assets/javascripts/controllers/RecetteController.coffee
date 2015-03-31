controllers = angular.module('controllers')

controllers.controller "RecetteController", ($scope,$routeParams,$resource,$location, flash, FileUploader) ->

    Recette = $resource('/recettes/:recetteId', { recetteId: "@id", format: 'json' },
      {
        'save': {method:'PUT'},
        'create': {method:'POST'}
      }
    )

    # Instancier la classe d'upload
    $scope.uploader = new FileUploader({url: 'recettes', alias: "image"})

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

    # Methodes

    $scope.uploader.onAfterAddingFile = (item) ->
      item.formData.push
        'name': $scope.recette.name
        'instructions': $scope.recette.instructions

    $scope.back   = -> $location.path "/"
    $scope.edit   = -> $location.path "/recettes/#{$scope.recette.id}/edit"
    $scope.cancel = ->
      if $scope.recette.id
        $location.path "/recettes/#{$scope.recette.id}"
      else
        $location.path "/"

    $scope.delete = ->
      $scope.recette.$delete()
      $scope.back()