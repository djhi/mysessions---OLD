# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

Schemas.Session = new SimpleSchema
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

Collections.Sessions = new Meteor.Collection 'sessions'
Collections.Sessions.attachSchema Schemas.Session

Collections.Sessions.helpers
  course: ->
    return Collections.Courses.findOne @courseId

if Meteor.isClient
  @Collections.Sessions.helpers
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
          participantList += ' (' + TAPi18n.__("yearsOld", age) + ')'

        participantList += ': '
        
        if participant._id in session.participantsIds
          participantList += TAPi18n.__ "wasAttending"
        else
          participantList += TAPi18n.__ "wasMissing"

        participantList += '\r\n'

      body = if session.notes then session.notes + '\r\n\r\n' else ''
      body += TAPi18n.__ 'participantsList'
      body += ':\r\n\r\n' + participantList
      body += '\r\n\r\n' + Meteor.user().profile.fullname

      return {
        subject: moment(session.date).format('L') + ': ' + TAPi18n.__ 'sessionReportForCourse', course: course.title
        body: body
      }
