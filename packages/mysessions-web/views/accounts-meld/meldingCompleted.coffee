Template.meldingCompleted.events
  'click #closeButton': (event, template) ->
    event.preventDefault()
    MeldActions.remove @_id
    return false
