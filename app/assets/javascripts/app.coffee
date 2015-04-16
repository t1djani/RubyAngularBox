box = angular.module("boxmaster", [
  'templates',
  'ngRoute',
  'ngResource',
  'Devise',
  'controllers',
  'directives',
  'services',
  'filters',
  'ngSanitize',
  'ui.select',
  'ui.bootstrap',
  'angularFileUpload'
])


box.config ( $routeProvider ) ->

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'IndexController'
      ).when('/login',
        templateUrl: "auth/_login.html"
        controller: 'AuthController'
      ).when('/register',
        templateUrl: "auth/_register.html"
        controller: 'AuthController'
      ).when('/recettes/new',
        templateUrl: "form.html"
        controller: 'RecetteController'
      ).when('/recettes/:id',
        templateUrl: "show.html"
        controller: 'RecetteController'
      ).when('/recettes/:id/edit',
        templateUrl: "form.html"
        controller: 'RecetteController'
      ).when('/users/:id',
        templateUrl: "auth/index.html"
        controller: 'AuthController'
      ).when('/carnets/:id',
        templateUrl: 'showCarnet.html'
        controller: 'CarnetController'
      ).when('/recettes_carnet/:id'
        templateUrl: 'show_recette_carnet.html'
        controller: 'RecetteController')


controllers = angular.module 'controllers', []
directives  = angular.module 'directives', []
services  = angular.module 'services', []
filters     = angular.module 'filters', []
