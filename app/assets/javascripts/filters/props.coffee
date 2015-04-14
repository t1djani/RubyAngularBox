filters = angular.module 'filters'

filters.filter 'propsFilter', ->
  (items, props) ->
    out = []
    if angular.isArray(items)
      items.forEach (item) ->
        itemMatches = false
        keys = Object.keys(props)
        i = 0
        while i < keys.length
          prop = keys[i]
          text = props[prop].toLowerCase()
          if item[prop].toString().toLowerCase().indexOf(text) != -1
            itemMatches = true
            break
          i++
        if itemMatches
          out.push item
        else
          out = items
        out
