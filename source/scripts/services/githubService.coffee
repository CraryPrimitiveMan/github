define [
  'app'
  'base64'
], (app, base64) ->
  app.registerFactory 'githubService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->

      scopes = [
        'user', 'repo', 'repo_deployment', 'delete_repo', 'notifications',
        'gist', 'admin:repo_hook', 'admin:org_hook', 'admin:org', 'admin:public_key'
      ]
      apiUrl = 'https://api.github.com'
      $http.defaults.headers =
        common:
          'Accept': 'application/vnd.github.v3+json'
          # 'application/vnd.github.v3.raw+json'
        post:
          'Content-Type': 'application/json;charset=utf-8'
        put:
          'Content-Type': 'application/json;charset=utf-8'

      githubService = {}

      githubService.init = (options = {}) ->
        if options.token or (options.username and options.password)
          $http.defaults.headers.common.authorization = if options.token then 'token ' + options.token else 'Basic ' + base64.encode(options.username + ':' + options.password)
        githubService
      githubService.user = {
        info: ->
          $http.get apiUrl + '/user'
      }

      githubService
  ]
