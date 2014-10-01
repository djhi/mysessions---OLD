# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Participant = new SimpleSchema
  subscribedAt:
    type: Date
    i18nLabel: 'subscribedAt'
    optional: true
    denyUpdate: true
    autoValue: ->
      if @isInsert then return new Date()
      return

  userId:
    type: String
    i18nLabel: 'owner'
    denyUpdate: true
    autoValue: ->
      if @isInsert then return Meteor.userId()
      return

  courseId:
    type: String
    i18nLabel: 'course'
    min: 3
    max: 100

  name:
    type: String
    i18nLabel: 'name'
    min: 3
    max: 100

  birthDate:
    type: Date
    i18nLabel: 'birthDate'
    optional: true

  phone:
    type: String
    i18nLabel: 'phone'
    optional: true
    min: 10
    max: 10

  emergencyPhone:
    type: String
    i18nLabel: 'emergencyPhone'
    optional: true
    min: 10
    max: 10

@Collections.Participants = new Meteor.Collection 'participants'
@Collections.Participants.attachSchema @Schemas.Participant

Collections.Participants.helpers
  course: ->
    return Collections.Courses.findOne @courseId

  age: ->
    return moment().diff moment(@birthDate), 'years' if @birthDate
    return undefined
