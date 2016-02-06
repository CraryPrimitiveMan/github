define [
  'app'
  'services/githubService'
], (app) ->
  app.registerController 'app.ctrl.login', [
    '$scope'
    '$state'
    '$rootScope'
    '$ionicPopup'
    'githubService'
    ($scope, $state, $rootScope, $ionicPopup, githubService) ->
      vm = this
      $scope.doLogin = ->
        if not vm.username or not vm.password
          $ionicPopup.alert(
            title: 'Waring'
            template: 'User name or password is empty'
          )

        githubService.getToken(vm.username, vm.password).success (data) ->
          $rootScope.isLogin = true
          githubService.setToken data
          $state.go 'events'


        # options =
        #   username: vm.username
        #   password: vm.password
        # githubService.init(options).user.info().success((data) ->
        #   alert(JSON.stringify(data))
        # )

      return
  ]
