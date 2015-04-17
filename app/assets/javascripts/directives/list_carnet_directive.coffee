directives = angular.module 'directives'

directives.directive 'listCarnet', ($location, $modal, Carnet, $routeParams)->
  restrict: "EA"
  scope:
    carnet: "="
  templateUrl: 'list_carnets.html'
  link: (scope, element, attr) ->
    scope.view = (listId) ->
      $location.path "/carnets/#{listId}"

    scope.delete = ->
      modalInstance = $modal.open
        templateUrl: 'modals/delete.html'
        controller:
          ($scope, $modalInstance, $route) ->

            $scope.ok = ->
              Carnet.delete( id: scope.carnet.id, (carnet) ->
                carnet.id = scope.carnet.id
              )
              $route.reload()
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'

    scope.editCarnet = ->
      modalInstance = $modal.open
        templateUrl: 'modals/edit_carnet.html'
        controller:
          ($scope, $modalInstance, $route) ->

            $scope.ok = ->
              Carnet.update( id: scope.carnet.id, (carnet) ->
                carnet.book = scope.carnet.book
                carnet.description = scope.carnet.description
              )
              $route.reload()
              $modalInstance.close()

            $scope.cancel = ->
              $modalInstance.dismiss 'cancel'
