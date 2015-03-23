box = angular.module("boxmaster", [
	'templates',
  'ngRoute',
  'ngResource'
  'controllers',
  'angularFileUpload'
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])


box.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'RecettesController'
      ).when('/recettes/new',
        templateUrl: "form.html"
        controller: 'RecetteController'
      ).when('/recettes/:recetteId',
        templateUrl: "show.html"
        controller: 'RecetteController'
      ).when('/recettes/:recetteId/edit',
        templateUrl: "form.html"
        controller: 'RecetteController'
      )
])

controllers = angular.module('controllers', [])