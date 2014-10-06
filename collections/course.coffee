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
    defaultValue: null

@Collections.Courses = new Meteor.Collection 'courses'
@Collections.Courses.attachSchema @Schemas.Course

Collections.Courses.helpers
  participants: ->
    return Collections.Participants.find
      _id: $in: @participantsIds
    ,
      sort: name: 1

  sessions: ->
    return Collections.Sessions.find
      courseId: @_id
    ,
      sort: date: -1
