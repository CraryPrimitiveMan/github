###global define, require ###

define [
  'angular'
  'angularUIRouter'
  'angularLazyLoad'
  'ionicAngular'
  'ngCordova'
  'core'
  'loader'
], (angular, uiRouter, lazyLoad) ->
  'use strict'
  app = angular.module('app', [
    'ionic'
    'ui.router'
    'scs.couch-potato'
    'ngCordova'
    'core'
  ])

  # Enable lazyloading for app module
  lazyLoad.configureApp app

  app.config([
    '$stateProvider'
    '$urlRouterProvider'
    '$locationProvider'
    '$couchPotatoProvider'
    ($stateProvider, $urlRouterProvider, $locationProvider, $couchPotatoProvider) ->
      # $locationProvider.html5Mode true
      templateBasePath = '/partials'

      $urlRouterProvider.otherwise('/login')
      # Set up the states
      $stateProvider.state 'login',
        url: '/login'
        templateUrl: templateBasePath + '/login.html'
        controller: 'app.ctrl.login'
        controllerAs: 'login'
        resolve:
          l: $couchPotatoProvider.resolveDependencies ['./controllers/loginCtrl']

      $stateProvider.state 'events',
        url: '/events'
        templateUrl: templateBasePath + '/events.html'
        controller: 'app.ctrl.events'
        controllerAs: 'events'
        resolve:
          l: $couchPotatoProvider.resolveDependencies ['./controllers/eventsCtrl']

      $stateProvider.state 'profile',
        url: '/profile'
        templateUrl: templateBasePath + '/profile.html'
        controller: 'app.ctrl.profile'
        controllerAs: 'profile'
        resolve:
          l: $couchPotatoProvider.resolveDependencies ['./controllers/profileCtrl']

      return
  ]).run([
    '$ionicPlatform'
    '$couchPotato'
    'dbService'
    ($ionicPlatform, $couchPotato, dbService) ->
      # Config the lazy load
      app.lazy = $couchPotato
      $ionicPlatform.ready ->
        #dbService.init()
        # Hide the accessory bar by default (remove this to show the accessory bar above the keyboard for form inputs)
        if window.cordova and window.cordova.plugins.Keyboard
          cordova.plugins.Keyboard.hideKeyboardAccessoryBar true
          cordova.plugins.Keyboard.disableScroll true

        if window.StatusBar
          # org.apache.cordova.statusbar required
          StatusBar.styleDefault()
        return

      return
    ]
  )
#
# .config(function($stateProvider, $urlRouterProvider) {
#   $stateProvider
#
#     .state('app', {
#     url: '/app',
#     abstract: true,
#     templateUrl: 'templates/menu.html',
#     controller: 'AppCtrl'
#   })
#
#   .state('app.search', {
#     url: '/search',
#     views: {
#       'menuContent': {
#         templateUrl: 'templates/search.html'
#       }
#     }
#   })
#
#   .state('app.browse', {
#       url: '/browse',
#       views: {
#         'menuContent': {
#           templateUrl: 'templates/browse.html'
#         }
#       }
#     })
#     .state('app.playlists', {
#       url: '/playlists',
#       views: {
#         'menuContent': {
#           templateUrl: 'templates/playlists.html',
#           controller: 'PlaylistsCtrl'
#         }
#       }
#     })
#
#   .state('app.single', {
#     url: '/playlists/:playlistId',
#     views: {
#       'menuContent': {
#         templateUrl: 'templates/playlist.html',
#         controller: 'PlaylistCtrl'
#       }
#     }
#   });
#   // if none of the above states are matched, use this as the fallback
#   $urlRouterProvider.otherwise('/app/playlists');
# });
