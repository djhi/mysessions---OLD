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

  address:
    type: String
    i18nLabel: 'address'
    optional: true
    min: 3
    max: 100

  city:
    type: String
    i18nLabel: 'city'
    optional: true
    min: 3
    max: 100

  zipCode:
    type: String
    i18nLabel: 'zipCode'
    optional: true
    min: 5
    max: 5

  emergencyPhone:
    type: String
    i18nLabel: 'emergencyPhone'
    optional: true
    min: 10
    max: 10

@Collections.Participants = new Meteor.Collection 'participants'
@Collections.Participants.attachSchema @Schemas.Participant

Collections.Participants.helpers
  courses: ->
    return Collections.Courses.find participantsIds: @_id

  age: ->
    return moment().diff moment(@birthDate), 'years' if @birthDate
    return undefined
