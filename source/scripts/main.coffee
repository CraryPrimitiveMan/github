###global requirejs, document, cordova, window, navigator, console ###

requirejs.config
  paths:
    angular: '../lib/angular.min'
    angularAnimate: '../lib/angular-animate.min'
    angularSanitize: '../lib/angular-sanitize.min'
    angularLazyLoad: '../lib/angular-couch-potato'
    angularUIRouter: '../lib/angular-ui-router.min'
    ionic: '../lib/ionic.min'
    ionicAngular: '../lib/ionic-angular.min'
    github: '../lib/github'
    base64: '../lib/base64.min'
    ngCordova: '../lib/ng-cordova.min'
    marked: '../lib/marked.min'
  shim:
    angular: exports: 'angular'
    angularAnimate: deps: [ 'angular' ]
    angularSanitize: deps: [ 'angular' ]
    angularUIRouter: deps: [ 'angular' ]
    angularLazyLoad: deps: [ 'angular' ]
    ngCordova: deps: [ 'angular' ]
    ionic:
      deps: [ 'angular' ]
      exports: 'ionic'
    ionicAngular: deps: [
      'angular'
      'ionic'
      'angularUIRouter'
      'angularAnimate'
      'angularSanitize'
    ]
    base64:
      exports: 'base64'
      init: ->
        window.Base64
  priority: [
    'angular'
    'ionic'
  ]
  deps: [ 'bootstrap' ]
