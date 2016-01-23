define [
  'app'
  'base64'
  'config/client'
], (app, base64, client) ->
  app.registerFactory 'githubService', [
    '$rootScope'
    '$http'
    ($rootScope, $http) ->
      apiUrl = 'https://api.github.com'
      $http.defaults.headers =
        common:
          'Accept': 'application/vnd.github.v3+json'
          #'Accept': 'application/vnd.github.v3.raw+json'
        post:
          'Content-Type': 'application/json;charset=utf-8'
        put:
          'Content-Type': 'application/json;charset=utf-8'

      githubService = {}

      githubService.getToken = (username, password) ->
        config =
          headers: authorization: 'Basic ' + base64.encode(username + ':' + password)
        data =
          client_secret: client.secret,
          scopes: client.scopes
          note: client.note

        $http.put apiUrl + '/authorizations/clients/' + client.id, data, config

      githubService.setToken = (data) ->
        $http.defaults.headers.common.authorization = 'token ' + data.token
        return

      githubService.user = {
        info: ->
          $http.get apiUrl + '/user'
      }
      githubService.events = {
        received: ->
          $http.get apiUrl + '/users/CraryPrimitiveMan/received_events'
      }

      githubService
  ]
