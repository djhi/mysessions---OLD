Template.sendSessionReport.created = ->
  # Build the participant list
  participantList = ''
  session = @data.session
  participants = @data.participants
  course = @data.course

  participants.forEach (participant) ->
    participantList += participant.name + ' (' + participant.age + ' ans): '

    if participant._id in session.participantsIds
      participantList += " présent"
    else
      participantList += " absent"

    participantList += '\r\n'

  sessionReport =
    subject: course.title + ": Session du " + moment(session.date).format('L')
    body: session.notes + '\r\n\r\nListe des inscrits:\r\n\r\n' + participantList

  @data.sessionReport = sessionReport

Template.sendSessionReport.helpers
  sessionReportSchema: ->
    schema = Schemas.SessionReport
    return schema

AutoForm.addHooks 'sessionReportForm',
  onSuccess: (operation, result, template) ->
    Notifications.success '', 'Rapport envoyé !'

  onError: (operation, error, template) ->
    Notifications.error '', 'Une erreur est survenue...'
