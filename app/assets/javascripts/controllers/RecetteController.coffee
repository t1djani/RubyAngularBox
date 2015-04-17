controllers = angular.module 'controllers'

controllers.controller "RecetteController", ( $scope,$routeParams,$resource,$location, FileUploader, $modal, $log, Ingredient, Recette, Auth, Carnet ) ->

    $scope.availableIngredients = []

    $scope.uploader = new FileUploader( url: 'recettes', alias: "image" )

    Ingredient.query ( data ) ->
      $scope.availableIngredients = data.ingredients.map ( ingredient ) -> ingredient.name

    Auth.currentUser().then ( user ) ->
      $scope.user = user

    if $routeParams.id
      Recette.get { id: $routeParams.id },
        ( ( recette ) ->
          $scope.recette = recette.recette
          $scope.recette.ingredients = recette.ingredients.map ( ingredient ) -> ingredient.name ),
        ( ( httpResponse ) ->
          $scope.recette = null
          $scope.alerts =
            type: 'danger'
            msg: 'Désolé ! La recette que vous cherchez n\'existe pas'
        )
    else
      $scope.recette = {}
      $scope.recette.ingredients = []

    # Methodes

    $scope.open = ->
      modalInstance = $modal.open(
        templateUrl: 'modals/delete.html'
        controller:
          ( $scope, $modalInstance ) ->
            $scope.ok = ->
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'
      )

      modalInstance.result.then ( () ->
        Recette.get( id: $scope.recette.id, ( recette ) ->
          recette.id           = $scope.recette.id
          recette.$delete( {}, -> $scope.back() )
        )
      )

    $scope.favorite = ->
      modalInstance = $modal.open(
        templateUrl: 'modals/add_favorite.html'
        controller:
          ( $scope, $modalInstance ) ->
            Carnet.modalCarnet ( data ) ->
              $scope.carnets = data.carnets

            Recette.get { id: $routeParams.id },
             ( data ) ->
              $scope.recette = data.recette

            $scope.selected =
              carnet: $scope.carnets

            $scope.ok = ->
              Recette.addToCarnet( id: $scope.recette.id, carnet_id: $scope.selected.carnet.id ,( recette ) ->
                recette.recettes = $scope.recette
              )
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'
      )

    $scope.save = ->
      if $scope.uploader.queue.length is 0
        # --- NO FILE TO UPLOAD ---
        # We'll deal with the save/update using ngResource
        if $scope.recette.id?
          # --- Update ---
          # OK OK OK OK OK
          Recette.get( id: $scope.recette.id, ( recette ) ->
            recette.id           = $scope.recette.id
            recette.name         = $scope.recette.name
            recette.instructions = $scope.recette.instructions
            recette.ingredients  = $scope.recette.ingredients
            recette.$update( {}, -> $scope.back() )
          )
        else
          # --- Create ---
          # OK OK OK OK OK
          recette = new Recette()
          recette.name         = $scope.recette.name
          recette.instructions = $scope.recette.instructions
          recette.ingredients = $scope.recette.ingredients
          recette.user_id     = $scope.user.id
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
        $scope.uploader.queue[0].ingredients = $scope.recette.ingredients
        $scope.uploader.queue[0].user_id = $scope.user.id
        $scope.uploader.queue[0].upload()

    $scope.uploader.onAfterAddingFile = ( item ) ->
      item.formData.push
        'name': $scope.recette.name
        'instructions': $scope.recette.instructions
        'ingredients': $scope.recette.ingredients
        'user_id': $scope.user.id

    $scope.back   = ->
      $location.path "/"

    $scope.edit   = -> $location.path "/recettes/#{ $scope.recette.id }/edit"

    $scope.cancel = ->
      if $scope.recette.id
        $location.path "/recettes/#{ $scope.recette.id }"
      else
        $location.path "/"
