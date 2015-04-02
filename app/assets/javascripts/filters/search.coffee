filters = angular.module 'filters', []
filters.filter 'filtre', ->
  (items, show) ->
    filtered = []
    for item in items
      if show is false
        filtered.push item
      else if show is true and item.image.image.url?
        filtered.push item
    filtered
