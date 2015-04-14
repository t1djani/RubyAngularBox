services  = angular.module 'services'

services.factory 'Recette', ($resource) ->

  $resource '/recettes/:id', { id: '@id', format: 'json' },
  {
    'update': { method: 'PUT' }
    'query': { method: 'get', isArray: false }
  }

services.factory 'Ingredient', ($resource) ->

  $resource '/ingredients/:id', { id: '@id', format: 'json' },
  {
    'query': { method: 'get', isArray: false }
  }
