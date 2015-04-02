filters = angular.module 'filters', []
filters.filter 'filtre', ->
  (items, show) ->
    filtered = []
    debugger
    for item in items
      if show.check == false
        filtered.push item
      else if show.check == true and item.name = 'Patates Douces'
        filtered.push item
    filtered
