# Lazy initialization of namespaces
@Schemas = @Schemas or {}
@Collections = @Collections or {}

@Schemas.ReportRecipient = new SimpleSchema
  userId:
    type: String
    i18nLabel: 'owner'
    autoValue: -> return Meteor.userId()

  email:
    type: String
    i18nLabel: 'email'
    min: 3
    max: 100

@Collections.ReportRecipients = new Meteor.Collection 'reportRecipients'
@Collections.ReportRecipients.attachSchema @Schemas.ReportRecipient
