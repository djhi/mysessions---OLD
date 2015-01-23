Router.configure
  layoutTemplate: 'layout'
  yieldTemplates:
    header:
      to: 'header'
    footer:
      to: 'footer'
  onBeforeAction: ->
    $('#mainContent').css 'display', 'none'
    @next()
    return
  onAfterAction: ->
    $('#mainContent').velocity "transition.slideLeftBigIn", 1000
    return
  unload: ->
    Session.set 'previousRoute', @path
    return

Meteor.startup ->
  window.i18n = new i18nHelper()
