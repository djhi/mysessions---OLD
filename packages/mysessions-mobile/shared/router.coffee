Router.configure
  layoutTemplate: 'layout'
  yieldTemplates:
    header:
      to: 'header'
    footer:
      to: 'footer'
  unload: ->
    Session.set 'previousRoute', @path
    return

Router.plugin 'loading', loadingTemplate: 'loading'

Router.onBeforeAction AccountsTemplates.ensureSignedIn, except: [
  'atSignIn'
  'atSignUp'
  'atForgotPwd'
  'atResetPwd'
  'sign-in'
  'home'
]
