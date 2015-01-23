SessionSchema = new SimpleSchema
  courseId:
    type: String
    i18nLabel: 'course'
    denyUpdate: true
    min: 3
    max: 100

  userId:
    type: String
    i18nLabel: 'owner'
    denyUpdate: true
    autoValue: ->
      if @isInsert then return Meteor.userId()
      return

  date:
    type: Date
    i18nLabel: 'date'
    defaultValue: new Date()

  participantsIds:
    type: [String]
    i18nLabel: 'participants'

  notes:
    type: String
    i18nLabel: 'notes'
    optional: true

Sessions = new Meteor.Collection 'sessions'
Sessions.attachSchema SessionSchema

Sessions.helpers
  course: ->
    return Courses.findOne @courseId

if Meteor.isClient
  Sessions.helpers
    getDefaultReport: ->
      session = @
      course = session.course()
      participants = course.participants()

      # Build the participant list
      participantList = ''

      participants.forEach (participant) ->
        participantList += participant.name

        if participant.birthDate
          age = moment().diff moment(participant.birthDate), 'years'
          participantList += ' (' + TAPi18n.__('yearsOld', age) + ')'

        participantList += ': '

        if participant._id in session.participantsIds
          participantList += TAPi18n.__ 'wasAttending'
        else
          participantList += TAPi18n.__ 'wasMissing'

        if participant.phone
          participantList += '\r\n\t'
          participantList += TAPi18n.__('phone') + ': ' + participant.phone

        if participant.emergencyPhone
          participantList += '\r\n\t'
          participantList += TAPi18n.__('emergencyPhone') + ': ' + participant.emergencyPhone

        if participant.address
          participantList += '\r\n\t'
          participantList += TAPi18n.__('address') + ': ' + participant.address

        if participant.city or participant.zipCode
          participantList += '\r\n\t'
          if participant.city
            participantList += TAPi18n.__('city') + ': ' + participant.city
            if participant.zipCode then participantList += ' ('

          if participant.zipCode
            if not participant.city then participantList += TAPi18n.__('zipCode') + ': '
            participantList += participant.zipCode
            if participant.city then participantList += ')'

        participantList += '\r\n'

      body = if session.notes then session.notes + '\r\n\r\n' else ''
      body += TAPi18n.__ 'participantsList'
      body += ':\r\n\r\n' + participantList

      if Meteor.user().profile.signature
        body += '\r\n' + Meteor.user().profile.signature
      else
        body += '\r\n' + Meteor.user().profile.fullname

      return {
        subject: moment(session.date).format('L') + ': ' + TAPi18n.__ 'sessionReportForCourse', course: course.title
        body: body
      }
