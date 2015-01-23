ReportRecipientSchema = new SimpleSchema
  userId:
    type: String
    i18nLabel: 'owner'
    autoValue: -> return Meteor.userId()

  email:
    type: String
    i18nLabel: 'email'
    min: 3
    max: 100

ReportRecipients = new Meteor.Collection 'reportRecipients'
ReportRecipients.attachSchema ReportRecipientSchema
