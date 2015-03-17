describe "RecetteController", ->
  scope        = null
  ctrl         = null
  routeParams  = null
  httpBackend  = null
  flash        = null
  recetteId     = 42

  fakeRecette   =
    id: recetteId
    name: "Patates Sauté"
    instructions: "Cuire dans l'eau bouillante pdt 20min"

  setupController =(recetteExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.recetteId = recetteId
      flash = _flash_

      request = new RegExp("\/recettes/#{recetteId}")
      results = if recetteExists
        [200,fakeRecette]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0],results[1])


      ctrl        = $controller('RecetteController',
                                $scope: scope)
    )

  beforeEach(module("boxmaster"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'recette trouvé', ->
      beforeEach(setupController())
      it 'charger la recette donné', ->
        httpBackend.flush()
        expect(scope.recette).toEqualData(fakeRecette)
    describe 'recette non trouvé', ->
      beforeEach(setupController(false))
      it 'charger la recette', ->
        httpBackend.flush()
        expect(scope.recette).toBe(null)
        
        expect(flash.error).toBe("Il n'y a pas de recette avec cet ID: #{recetteId}")