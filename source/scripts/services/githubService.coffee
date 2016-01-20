define [
  'app'
  'github'
], (app, Github) ->
  app.registerFactory 'githubService', [
    '$rootScope'
    ($rootScope) ->
      githubService = {}
      githubService.init = (options = {}) ->
        options.auth = 'basic' if angular.isObject(options) and not angular.equals({}, options)
        $rootScope.github = new Github options unless $rootScope.github
        $rootScope.github
      githubService
  ]
