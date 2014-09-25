Template._cancel.helpers
  label: () ->
    return @label or TAPi18n.__ 'cancel'

Template._cancel.events
  'click .btn-cancel': (event, template) ->
    event.preventDefault()
    Router.go Session.get 'previousRoute'
    return false
