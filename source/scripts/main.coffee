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
    xmlhttprequest: '../lib/XMLHttpRequest'
    'js-base64': '../lib/base64.min'
  shim:
    angular: exports: 'angular'
    angularAnimate: deps: [ 'angular' ]
    angularSanitize: deps: [ 'angular' ]
    angularUIRouter: deps: [ 'angular' ]
    angularLazyLoad: deps: [ 'angular' ]
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
    'js-base64':
      exports: 'js-base64'
      init: ->
        window
    'xmlhttprequest':
      exports: 'xmlhttprequest'
      init: ->
        window
    github: deps: [
      'js-base64'
      'xmlhttprequest'
    ]
  priority: [
    'angular'
    'ionic'
  ]
  deps: [ 'bootstrap' ]
