define [
  'core'
], (app) ->
  app.factory 'dbService', [
    '$rootScope'
    ($rootScope) ->
      dbService = {}
      dbService.init = () ->

        return
      dbService
  ]
