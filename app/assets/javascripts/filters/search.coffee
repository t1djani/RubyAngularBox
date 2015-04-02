filters = angular.module 'filters'
filters.filter 'filtre', ->
  (items, show) ->
    filtered = []
    for item in items
      if show is false
        filtered.push item
      else if show is true and item.name is "Patate Douces"
        filtered.push item
    filtered
