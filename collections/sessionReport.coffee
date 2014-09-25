# Lazy initialization of namespaces
@Schemas = @Schemas or {}

@Schemas.SessionReport = new SimpleSchema
  recipients:
    type: String
    label: 'Destinataires'
    min: 3
    max: 200

  subject:
    type: String
    label: 'Sujet'
    min: 3
    max: 200

  body:
    type: String
    label: 'Message'
    optional: true
