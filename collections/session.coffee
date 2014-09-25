# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Session = new SimpleSchema
  courseId:
    type: String
    label: 'Cours'
    min: 3
    max: 100

  date:
    type: Date
    label: 'Date'
    defaultValue: new Date

  participantsIds:
    type: [String]
    label: 'Participants'

  notes:
    type: String
    label: 'Notes'
    optional: true

@Collections.Sessions = new Meteor.Collection 'sessions'
@Collections.Sessions.attachSchema @Schemas.Session
