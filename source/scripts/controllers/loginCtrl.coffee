define [
  'app'
  'services/githubService'
], (app) ->
  app.registerController 'app.ctrl.login', [
    '$scope'
    '$state'
    '$ionicPopup'
    'githubService'
    ($scope, $state, $ionicPopup, githubService) ->
      vm = this
      $scope.doLogin = ->
        if not vm.username or not vm.password
          $ionicPopup.alert(
            title: '提示'
            template: 'User name or password is empty'
          )

        options =
          username: vm.username
          password: vm.password
        githubService.init(options).user.info().success((data) ->
          alert(JSON.stringify(data))
        )

      return
  ]
