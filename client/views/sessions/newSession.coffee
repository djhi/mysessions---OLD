Template.newSession.events
  'change [type=checkbox]': (event, template) ->
    $(event.currentTarget).parent('label').toggleClass 'btn-success'
    return false

  'click .btn-send-report': (event, template) ->
    Session.set 'send-report', true
    return

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

      if Session.get 'send-report' then Router.go 'sendSessionReport',
        courseId: template.data.course._id
        _id: sessionId
      else
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
  Session.set 'send-report', false

  Tracker.autorun ->
    momentFormat = moment.localeData(i18n.getLanguageCode()).longDateFormat('L')
    template.$('.datepicker').data('datepicker').format = momentFormat

  @$('.btn-checkbox').button()
  return
