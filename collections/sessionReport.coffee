# Lazy initialization of namespaces
@Schemas = @Schemas or {}

@Schemas.SessionReport = new SimpleSchema
  recipients:
    type: String
    i18nLabel: 'recipients'
    min: 3
    max: 200

  subject:
    type: String
    i18nLabel: 'subject'
    min: 3
    max: 200

  body:
    type: String
    i18nLabel: 'mailBody'
    optional: true
