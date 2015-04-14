box = angular.module("boxmaster", [
  'templates',
  'ngRoute',
  'ngResource',
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
      ).when('/recettes/new',
        templateUrl: "form.html"
        controller: 'RecetteController'
      ).when('/recettes/:id',
        templateUrl: "show.html"
        controller: 'RecetteController'
      ).when('/recettes/:id/edit',
        templateUrl: "form.html"
        controller: 'RecetteController'
      )


controllers = angular.module 'controllers', []
directives  = angular.module 'directives', []
services  = angular.module 'services', []
filters     = angular.module 'filters', []
