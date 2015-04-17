directives = angular.module 'directives'

directives.directive 'carnetRecettes', ($location, $modal, Carnet, $routeParams)->
  restrict: "EA"
  scope:
    recette: "="
  templateUrl: 'list_recettesCarnet.html'
  link: (scope, element, attr) ->
    scope.view = (recetteId) -> $location.path "/recettes_carnet/#{recetteId}"

    scope.delete = ->
      modalInstance = $modal.open
        templateUrl: 'modals/delete.html'
        controller:
          ($scope, $modalInstance) ->

            $scope.ok = ->
              Carnet.deleteToCarnet( id: scope.recette.id, carnet_id: $routeParams.id ,( carnet ) ->
                carnet.recettes = recette
              )
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'
