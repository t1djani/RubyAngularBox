controllers = angular.module('controllers')

controllers.controller "RecetteController", ($scope,$routeParams,$resource,$location, FileUploader, $modal, $log) ->

    Recette = $resource '/recettes/:id', { id: '@id', format: 'json' },
    {
      'update': { method: 'PUT' }
    }

    $scope.uploader = new FileUploader( url: 'recettes', alias: "image" )

    if $routeParams.id
      Recette.get { id: $routeParams.id },
        ( (recette, ingredients) ->
          $scope.recette = recette.recette
          $scope.ingredients = recette.ingredients ),
        ( (httpResponse) ->
          $scope.recette = null
          $scope.alerts =
            type: 'danger'
            msg: 'Oh snap! La recette que vous cherchez n\'existe pas'
        )
    else
      $scope.recette = {}

    $scope.open = ->
      modalInstance = $modal.open(
        templateUrl: 'delete.html'
        controller:
          ($scope, $modalInstance) ->
            $scope.ok = ->
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'
      )

      modalInstance.result.then ( () ->
        Recette.get( id: $scope.recette.id, (recette) ->
          recette.id           = $scope.recette.id
          recette.$delete( {}, -> $scope.back() )
        )
      )

    # Methodes

    $scope.save = ->
      if $scope.uploader.queue.length is 0
        # --- NO FILE TO UPLOAD ---
        # We'll deal with the save/update using ngResource
        if $scope.recette.id?
          # --- Update ---
          # OK OK OK OK OK
          Recette.get( id: $scope.recette.id, (recette) ->
            recette.id           = $scope.recette.id
            recette.name         = $scope.recette.name
            recette.instructions = $scope.recette.instructions
            recette.$update( {}, -> $scope.back() )
          )
        else
          # --- Create ---
          # OK OK OK OK OK
          recette = new Recette()
          recette.name         = $scope.recette.name
          recette.instructions = $scope.recette.instructions
          recette.$save( {}, -> $scope.back() )

      else

        # --- FILE TO UPLOAD ---
        # Let FileUploader handle this
        $scope.uploader.queue[0].onSuccess = ->
          $scope.back()

        if $scope.recette.id?
          # --- Update ---
          # OK OK OK OK OK
          $scope.uploader.queue[0].url = "recettes/#{ $scope.recette.id }"
          $scope.uploader.queue[0].method = "PUT"

        $scope.uploader.queue[0].name = $scope.recette.name
        $scope.uploader.queue[0].instructions = $scope.recette.instructions
        $scope.uploader.queue[0].upload()

    $scope.uploader.onAfterAddingFile = (item) ->
      item.formData.push
        'name': $scope.recette.name
        'instructions': $scope.recette.instructions


    $scope.back   = ->
      $location.path "/"

    $scope.edit   =
      -> $location.path "/recettes/#{ $scope.recette.id }/edit"

    $scope.cancel = ->
      if $scope.recette.id
        $location.path "/recettes/#{ $scope.recette.id }"
      else
        $location.path "/"
