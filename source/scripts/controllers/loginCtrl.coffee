define [
  'app'
  'services/githubService'
], (app) ->
  app.registerController 'app.ctrl.login', [
    '$scope'
    '$state'
    'githubService'
    ($scope, $state, githubService) ->
      vm = this
      $scope.doLogin = ->
        options =
          username: vm.username
          password: vm.password
        user = githubService.init(options).getUser()
        user.show vm.username, (err, user) ->
          $state.go 'profile'
          console.log user

      return
  ]
