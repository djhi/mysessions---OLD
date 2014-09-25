# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.Participant = new SimpleSchema
  subscribedAt:
    type: Date
    label: 'Inscrit le'
    optional: true
    denyUpdate: true
    autoValue: ()->
      if @isInsert then return new Date
      return

  courseId:
    type: String
    label: 'Cours'
    min: 3
    max: 100

  name:
    type: String
    label: 'Nom'
    min: 3
    max: 100

  age:
    type: Number
    label: 'Âge'
    min: 0
    max: 99

  phone:
    type: String
    label: 'Téléphone'
    min: 10
    max: 10

  emergencyPhone:
    type: String
    label: 'Tél. Urgence'
    min: 10
    max: 10

@Collections.Participants = new Meteor.Collection 'participants'
@Collections.Participants.attachSchema @Schemas.Participant
