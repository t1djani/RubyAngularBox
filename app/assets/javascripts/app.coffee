box = angular.module("boxmaster", [
	'templates',
  	'ngRoute',
  	'controllers',
])


box.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: "index.html"
        controller: 'RecettesController'
      )
])

recettes = [
  {
    id: 1
    name: 'Patates sauté au fromage'
  },
  {
    id: 2
    name: 'Patate douce',
  },
  {
    id: 3
    name: 'Gratin de patates',
  },
  {
    id: 4
    name: 'Tout le reste',
  },
]

controllers = angular.module('controllers',[])
controllers.controller("RecettesController", [ '$scope', '$routeParams', '$location',
  ($scope,$routeParams,$location)->
    $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.recettes = recettes.filter (recette)-> recette.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.recettes = []
])
