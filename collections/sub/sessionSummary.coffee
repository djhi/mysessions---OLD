# Lazy initialization of namespaces
@Schemas = @Schemas or {}

Schemas = @Schemas

Schemas.SessionSummary = new SimpleSchema
  date:
    type: Date
    i18nLabel: 'date'

  participantsCount:
    type: Number
    i18nLabel: 'numberOfParticipants'
    defaultValue: 0
