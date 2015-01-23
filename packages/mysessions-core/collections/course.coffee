CourseSchema = new SimpleSchema
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
    type: SessionSummarySchema
    i18nLabel: 'lastSession'
    optional: true
    defaultValue: null

Courses = new Meteor.Collection 'courses'
Courses.attachSchema CourseSchema

Courses.helpers
  participants: ->
    return Participants.find
      _id: $in: @participantsIds
    ,
      sort: name: 1

  sessions: ->
    return Sessions.find
      courseId: @_id
    ,
      sort: date: -1
