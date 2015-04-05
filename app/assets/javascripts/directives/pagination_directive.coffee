directives = angular.module 'directives'
directives.run([
  '$templateCache'
  ($templateCache) ->
    $templateCache.put 'template/will_paginate/paginator.html', '<ul class="{{options.paginationClass}}">' + '  <li class="prev" ng-class="{true:\'disabled\'}[params.currentPage == 1]">' + '    <a ng-hide="params.currentPage == 1" ng-click="getPage(page - 1)" class="ng-binding">{{options.previousLabel}}</a>' + '    <span ng-show="params.currentPage == 1" class="ng-binding ng-hide">{{options.previousLabel}}</span>' + '  </li>' + '  <li ng-class="{active:params.currentPage == page.value, disabled:page.kind == \'gap\' }" ng-repeat-start="page in collection">' + '    <span ng-show="params.currentPage == page.value || page.kind == \'gap\'">{{page.value}}</span>' + '    <a ng-hide="params.currentPage == page.value || page.kind == \'gap\'" ng-click="getPage(page.value)">{{page.value}}</a>' + '  </li>' + '  <li ng-repeat-end></li>' + '  <li class="next" ng-class="{true:\'disabled\'}[params.currentPage == params.totalPages]">' + '    <a ng-hide="params.currentPage == params.totalPages" ng-click="getPage(params.currentPage + 1)">{{options.nextLabel}}</a>' + '    <span ng-show="params.currentPage == params.totalPages">{{options.nextLabel}}</span>' + '  </li>' + '</ul>'
    return
]).directive 'willPaginate', ->
  {
    restrict: 'ACE'
    templateUrl: 'template/will_paginate/paginator.html'
    scope:
      params: '='
      config: '='
      onClick: '='
    controller: [
      '$scope'
      ($scope) ->

        $scope.getPage = (num) ->
          if $scope.onClick
            $scope.onClick num
          return

        return
    ]
    link: ($scope) ->
      $scope.collection = []
      # This config option mimics the options here:
      # https://github.com/mislav/will_paginate/blob/master/lib/will_paginate/view_helpers.rb
      # NOTE: NOT ALL OPTIONS ARE IMPLEMENTED YET.

      ### Options
          :class -- CSS class name for the generated DIV (default: "pagination")
          :previousLabel -- default: "Previous"
          :nextLabel -- default: "Next"
          :innerWindow -- how many links are shown around the current page (default: 4)
          :outerWindow -- how many links are around the first and the last page (default: 1)
          :linkSeparator -- string separator for page HTML elements (default: single space)
          :paramName -- parameter name for page number in URLs (default: :page)
          :params -- additional parameters when generating pagination links
          (eg. :controller => "foo", :action => nil)
          :pageLinks -- when false, only previous/next links are rendered (default: true)
          :container -- toggles rendering of the DIV container for pagination links, set to
          false only when you are rendering your own pagination markup (default: true)
      ###

      $scope.defaults =
        paginationClass: 'pagination'
        previousLabel: 'Previous'
        nextLabel: 'Next'
        innerWindow: 1
        outerWindow: 1
        linkSeperator: ' '
        paramName: 'page'
        params: {}
        pageLinks: true
        container: true

      $scope.windowedPageNumbers = ->
        left = []
        middle = []
        right = []
        x = undefined
        windowFrom = $scope.params.currentPage - $scope.options.innerWindow
        windowTo = $scope.params.currentPage + $scope.options.innerWindow
        if windowTo > $scope.params.totalPages
          windowFrom -= windowTo - $scope.params.totalPages
          windowTo = $scope.params.totalPages
        if windowFrom < 1
          windowTo += 1 - windowFrom
          windowFrom = 1
          if windowTo > $scope.params.totalPages
            windowTo = $scope.params.totalPages
        # these are always visible
        x = windowFrom
        while x < windowTo + 1
          middle.push value: x
          x++
        # left window
        if $scope.options.outerWindow + 3 < middle[0].value
          x = 1
          while x < $scope.options.outerWindow + 1
            left.push value: x
            x++
          left.push
            value: '…'
            kind: 'gap'
        else
          x = 1
          while x < middle[0].value
            left.push value: x
            x++
        # right window
        if $scope.params.totalPages - $scope.options.outerWindow - 2 > middle[middle.length - 1].value
          right.push
            value: '…'
            kind: 'gap'
          x = $scope.params.totalPages - $scope.options.outerWindow
          while x < $scope.params.totalPages
            right.push value: x
            x++
        else
          # runs into visible pages
          x = middle[middle.length - 1].value + 1
          while x <= $scope.params.totalPages
            right.push value: x
            x++
        left.concat middle.concat(right)

      $scope.render = ->
        $scope.collection = $scope.windowedPageNumbers()
        return

      $scope.$watch 'config', (newVal) ->
        if typeof newVal == 'undefined'
          return
        $scope.options = angular.extend(angular.copy($scope.defaults, {}), angular.copy(newVal, {}))
        if $scope.params.currentPage
          $scope.render()
        return
      $scope.$watch 'params.currentPage', (newVal) ->
        if typeof newVal == 'undefined'
          return
        $scope.render()
        return
      return
  }
