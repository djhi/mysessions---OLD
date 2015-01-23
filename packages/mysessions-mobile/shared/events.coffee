Template.layout.events
  'click [data-action="sign-in"]': (event, template) ->
    Router.go 'atSignIn'
    return

$(document).on 'menubutton': (event) ->
  Settings.show()
  return

Template._cancel.events
  'click [data-action=cancel]': (event, template) ->
    Location.back()
