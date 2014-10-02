Template._cancel.helpers
  label: () ->
    return TAPi18n.__ @label or 'cancel'

Template._cancel.events
  'click .btn-cancel': (event, template) ->
    event.preventDefault()
    Router.go Session.get 'previousRoute'
    return false
