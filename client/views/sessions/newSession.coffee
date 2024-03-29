Template.newSession.events
  'change [type=checkbox]': (event, template) ->
    checkbox = $(event.currentTarget)
    label = checkbox.parent 'label'

    label.toggleClass 'btn-success'
    checkbox.blur()
    label.blur()
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
      Notifications.success()

      if Session.get 'send-report' then Router.go 'sendSessionReport',
        courseId: template.data.course._id
        _id: sessionId
      else
        Router.go 'participants', _id: template.data.course._id
    else
      Notifications.error()
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
