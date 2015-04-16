directives = angular.module 'directives'
directives.directive 'listing', ($location)->
  restrict: "EA"
  scope:
    recette: "="
  templateUrl: 'listing.html'
  link: (scope, element, attr) ->
    scope.view = (recetteId) -> $location.path "/recettes/#{recetteId}"
