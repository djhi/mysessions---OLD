# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Course = new SimpleSchema
  title:
    type: String
    i18nLabel: 'title'
    min: 3
    max: 100

  userId:
    type: String
    i18nLabel: 'owner'
    denyUpdate: true
    autoValue: ->
      if @isInsert then return Meteor.userId()
      return

  participantsIds:
    type: [String]
    i18nLabel: 'participants'
    optional: true

  lastSession:
    type: Schemas.SessionSummary
    i18nLabel: 'lastSession'
    optional: true

  participantsCount:
    type: Number
    i18nLabel: 'numberOfParticipants'
    defaultValue: 0

@Collections.Courses = new Meteor.Collection 'courses'
@Collections.Courses.attachSchema @Schemas.Course
