define [
  'app'
  'services/timeAgoService'
], (app) ->
  app.registerFilter 'timeAgo', [
    'timeAgoService'
    (timeAgoService) ->
      return (createdAt) ->
        createdAt = Date.parse(new Date(createdAt))
        now = Date.parse(new Date())
        diff = now - createdAt
        return timeAgoService.inWords(diff)
  ]
