AutoForm.addHooks 'newParticipantForm',
  onSuccess: (operation, result, template) ->
    Session.set 'showNewParticipant', false
    return

Template.newParticipant.helpers
  submitLabel: ->
    return TAPi18n.__ 'add'

Template.newParticipant.events
  'click .btn-cancel': (event, template) ->
    event.preventDefault()
    Session.set 'showNewParticipant', false
    return
