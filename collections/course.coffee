# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Course = new SimpleSchema
  title:
    type: String
    label: () ->
      language =  Meteor.user().profile.language
      return TAPi18n.__ 'title', {}, language
    min: 3
    max: 100

  userId:
    type: String
    label: () ->
      language =  Meteor.user().profile.language
      return TAPi18n.__ 'owner', {}, language
    denyUpdate: true,
    autoValue: ()->
      return Meteor.userId()

  participantsIds:
    type: [String]
    label: () ->
      language =  Meteor.user().profile.language
      return TAPi18n.__ 'participants', {}, language
    optional: true

@Collections.Courses = new Meteor.Collection 'courses'
@Collections.Courses.attachSchema @Schemas.Course
