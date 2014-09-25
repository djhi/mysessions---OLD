Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  yieldTemplates:
    header:
      to: 'header'
    footer:
      to: 'footer'

  onBeforeAction: ->
    $('meta[name^="description"]').remove()
    return
  unload: ->
    Session.set 'previousRoute', @path
    return

Router.onBeforeAction 'loading'

Router.onBeforeAction AccountsTemplates.ensureSignedIn, except: ['atSignIn', 'atSignUp', 'atForgotPassword', 'home']
