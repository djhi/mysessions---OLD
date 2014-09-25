Template.participants.events
  'click .btn-new-participant': (event, template) ->
    event.preventDefault()
    Session.set 'showNewParticipant', true
    return false

Template.participants.helpers
  showNewParticipant: ->
    return Session.get 'showNewParticipant'
