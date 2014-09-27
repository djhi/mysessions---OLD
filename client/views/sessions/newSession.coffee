Template.newSession.events
  'change [type=checkbox]': (event, template) ->
    $(event.currentTarget).parent('label').toggleClass 'btn-success'
    return false

  'click .btn-send-report': (event, template) ->
    event.preventDefault()
    Session.set 'send-report', true
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
      Notifications.success '', TAPi18n.__ "changesPersisted", timeout: 5000
      Router.go 'participants', _id: template.data.course._id
    else
      Notifications.error '', TAPi18n.__ "anErrorOccured"
    return false

Template.newSession.helpers
  showNewParticipant: ->
    return Session.get 'showNewParticipant'

Template.newSession.rendered = ->
  template = @
  @$('.datepicker').datepicker().datepicker 'set', moment()

  Tracker.autorun ->
    momentFormat = moment.localeData(i18n.getLanguageCode()).longDateFormat('L')
    template.$('.datepicker').data('datepicker').format = momentFormat

  @$('.btn-checkbox').button()
  return
