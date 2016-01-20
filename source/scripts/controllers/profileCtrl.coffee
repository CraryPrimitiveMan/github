define [
  'app'
  'services/githubService'
], (app) ->
  app.registerController 'app.ctrl.profile', [
    '$scope'
    '$state'
    'githubService'
    ($scope, $state, githubService) ->
      $scope.doLogin = ->
        user = githubService.init().getUser()
        user.show $scope.loginData.username, (err, user) ->
          $state.go 'profile'
          console.log user

      return
  ]
