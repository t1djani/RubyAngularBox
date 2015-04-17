controllers = angular.module 'controllers'

controllers.controller "CarnetsController", ( $scope,$routeParams,$location,$resource,$modal,$log,Carnet,Auth ) ->

  Carnet.query ( data ) ->
    $scope.carnets = data.carnets
    $scope.pagination.totalItems = data.totalItem

  $scope.pagination = {
    currentPage: 1
    perPage: 5
  }

  Auth.currentUser().then ( user ) ->
    $scope.user = user

  $scope.openAdd = ->
    modalInstance = $modal.open(
      templateUrl: 'modals/add_carnet_modal.html'
      controller:
        ( $scope, $modalInstance,$route ) ->
          Carnet.query ( data ) ->
            $scope.carnets = data.carnets

          $scope.add = ->
            carnet = new Carnet()
            carnet.book         = $scope.carnets.book
            carnet.description = $scope.carnets.description
            carnet.$save()
            $route.reload()
            $modalInstance.close()

          $scope.cancel = ->
            $modalInstance.dismiss 'cancel'

      resolve:
        carnets: ->
           $scope.carnets
    )

  $scope.pageChanged = ->
    Carnet.query( page: $scope.pagination.currentPage, ( results ) -> $scope.carnets = results.carnets )
