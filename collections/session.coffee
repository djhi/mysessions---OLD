# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Session = new SimpleSchema
  courseId:
    type: String
    i18nLabel: 'course'
    min: 3
    max: 100

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

@Collections.Sessions = new Meteor.Collection 'sessions'
@Collections.Sessions.attachSchema @Schemas.Session
