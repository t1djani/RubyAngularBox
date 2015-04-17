services  = angular.module 'services'

services.factory 'Recette', ($resource) ->

  $resource '/recettes/:id', { id: '@id', format: 'json' },
  {
    'update': { method: 'PUT' }
    'query': { method: 'get' }
    'addToCarnet': { method: 'put', url: '/recettes/:id/add_to_carnet' }
  }

services.factory 'Ingredient', ($resource) ->

  $resource '/ingredients/:id', { id: '@id', format: 'json' },
  {
    'query': { method: 'get', isArray: false }
  }

services.factory 'User', ($resource) ->

  $resource '/users/:id', { id: '@id', format: 'json' }

services.factory 'Carnet', ($resource) ->

  $resource '/carnets/:id', { id: '@id', format: 'json' },
  {
    'update': { method: 'PUT' }
    'query': { method: 'get', isArray: false }
    'modalCarnet': { method: 'get', url: '/carnets/modal' }
    'deleteToCarnet': { method: 'delete', url: '/carnets/:id/delete_to_carnet' }
    'delete': { method: 'delete', url: '/carnets/:id' }
  }
