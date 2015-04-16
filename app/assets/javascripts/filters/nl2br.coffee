filters = angular.module 'filters'
filters.filter 'nl2br', ->
  ( input ) ->
    input.replace(/\n/g, '<br>') if input?
