Template.editSession.events
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

    result = Collections.Sessions.update template.data.session._id,
      $set:
        date: date
        notes: notes
        participantsIds: participants

    if result > 0 then Notifications.success '', TAPi18n.__ "changesPersisted", timeout: 5000

    if result is 0 then Notifications.error '', TAPi18n.__ "anErrorOccured"

    if Session.get 'send-report' then Router.go 'sendSessionReport',
      courseId: template.data.course._id
      _id: template.data.session._id

    return false

Template.editSession.helpers
  showNewParticipant: ->
    return Session.get 'showNewParticipant'

  wasPresent: () ->
    return this._id in Template.instance().data.session.participantsIds

Template.editSession.rendered = ->
  template = @
  @$('.datepicker').datepicker()

  Tracker.autorun ->
    momentFormat = moment.localeData(i18n.getLanguageCode()).longDateFormat('L')
    template.$('.datepicker').data('datepicker').format = momentFormat

  @$('.btn-checkbox').button()
  return
