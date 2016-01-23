define [
  'core'
  'config/db'
], (app, db) ->
  app.factory 'dbService', [
    '$rootScope'
    '$cordovaSQLite'
    ($rootScope, $cordovaSQLite) ->
      dbService = {}
      dbService.db = null
      dbService.init = ->
        dbService.db = $cordovaSQLite.openDB db.name + '.db'
        angular.forEach db.tables, (table) ->
          columns = []
          angular.forEach table.columns, (column) ->
            columns.push column.name + ' ' + column.type
            return
          dbQuery = 'CREATE TABLE IF NOT EXISTS ' + table.name + ' (' + columns.join(',') + ')'
          $cordovaSQLite.execute(dbService.db, dbQuery)
            .then((res) ->
              alert 'Tables are created'
            , (err) ->
              alert err
            )

          return
        return
      dbService
  ]
