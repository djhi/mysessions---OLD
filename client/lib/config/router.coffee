Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  yieldTemplates:
    header:
      to: 'header'
    footer:
      to: 'footer'
  onBeforeAction: ->
    $('#mainContent').css 'display', 'none'
    return
  onAfterAction: ->
    $('#mainContent').velocity "transition.slideLeftBigIn", 1000
    return
  unload: ->
    Session.set 'previousRoute', @path
    return

Router.onBeforeAction AccountsTemplates.ensureSignedIn, except: [
  'atSignIn'
  'atSignUp'
  'atForgotPwd'
  'atResetPwd'
  'home'
]
