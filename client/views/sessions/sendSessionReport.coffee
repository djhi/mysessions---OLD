Template.sendSessionReport.created = ->
  # Build the participant list
  participantList = ''
  session = @data.session
  participants = @data.participants
  course = @data.course

  participants.forEach (participant) ->
    age = moment(participant.birthDate).add(1, 'years').fromNow(false);
    participantList += participant.name + ' (' + TAPi18n.__ "age", age + '): '

    if participant._id in session.participantsIds
      participantList += TAPi18n.__ "wasAttending"
    else
      participantList += TAPi18n.__ "wasMissing"

    participantList += '\r\n'

  sessionReport =
    subject: moment(session.date).format('L') + ': ' + TAPi18n.__ 'sessionReportForCourse', course.title
    body: session.notes + '\r\n\r\n' + TAPi18n.__ 'participantsList' + ':\r\n\r\n' + participantList

  @data.sessionReport = sessionReport

Template.sendSessionReport.helpers
  sessionReportSchema: ->
    schema = Schemas.SessionReport
    return schema

  sendLabel: ->
    return TAPi18n.__ "send"

AutoForm.addHooks 'sessionReportForm',
  onSuccess: (operation, result, template) ->
    Notifications.success '', TAPi18n.__ 'reportSend'

  onError: (operation, error, template) ->
    Notifications.error '', TAPi18n.__ 'anErrorOccured'
