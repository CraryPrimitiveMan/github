define [
  'app'
  'marked'
], (app, marked) ->
  app.registerFilter 'markdown', [
    ->
      return (text) ->
        marked text
  ]
