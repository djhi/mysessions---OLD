ProfileSchema = new SimpleSchema
  fullname:
    type: String
    i18nLabel: 'fullname'
    min: 3
    max: 200

  signature:
    type: String
    i18nLabel: 'signature'
    min: 3
    max: 200

  language:
    type: String
    i18nLabel: 'language'
    custom: () ->
      if not TAPi18n.getLanguages()[@value]?
        language = if not Meteor.isClient then Meteor.user().profile.language
        return TAPi18n.__ 'invalidLanguage', {}, language
