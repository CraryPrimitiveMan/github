define [
  'app'
  'services/githubService'
], (app) ->
  app.registerController 'app.ctrl.events', [
    '$scope'
    '$state'
    'githubService'
    ($scope, $state, githubService) ->
      vm = this
      githubService.events.received().success (events) ->
        vm.items = events
        return

      return
  ]
