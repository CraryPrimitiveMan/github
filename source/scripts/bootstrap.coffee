###global define, require, console, cordova, navigator ###

window.name = 'NG_DEFER_BOOTSTRAP!'
define [
  'ionic'
  'angular'
  'app'
], (ionic, angular, app) ->
  'use strict'
  $html = undefined

  onDeviceReady = ->
    angular.bootstrap document, [ app.name ]
    return

  document.addEventListener 'deviceready', onDeviceReady, false
  if typeof cordova == 'undefined'
    $html = angular.element(document.getElementsByTagName('html')[0])
    angular.element().ready ->
      try
        angular.bootstrap document, [ app.name ]
      catch e
        console.error e.stack or e.message or e
      return
  return
