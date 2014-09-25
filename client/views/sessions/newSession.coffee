Template.newSession.events
  'change [type=checkbox]': (event, template) ->
    $(event.currentTarget).parent('label').toggleClass 'btn-success'
    return false

  'click .btn-new-participant': (event, template) ->
    event.preventDefault()
    Session.set 'showNewParticipant', true
    return false

  'submit form': (event, template) ->
    event.preventDefault()

    date = template.$('.datepicker').datepicker('get').toDate()
    notes = template.$('#notes').val()

    participants = template.$('input:checked').map(->
      return $(this).val()
      ).get()

    session =
      courseId: template.data.course._id
      date: date
      notes: notes
      participantsIds: participants

    sessionId = Collections.Sessions.insert session

    if sessionId
      Notifications.success '', 'Session enregistrée !', timeout: 5000
      Router.go 'course', _id: template.data.course._id
    else
      Notifications.error '', 'Une erreur est survenue...'
    return false

Template.newSession.helpers
  showNewParticipant: ->
    return Session.get 'showNewParticipant'

Template.newSession.rendered = ->
  @$('.datepicker').datepicker().datepicker 'set', moment()
  @$('.btn-checkbox').button()
  return
