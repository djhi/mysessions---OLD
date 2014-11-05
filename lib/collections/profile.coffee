# Lazy initialization of namespaces
@Schemas = @Schemas or {}

@Schemas.Profile = new SimpleSchema
  fullname:
    type: String
    label: ->
      language = if not Meteor.isClient then Meteor.user().profile.language
      return TAPi18n.__ 'fullname', {}, language
    min: 3
    max: 200

  language:
    type: String
    label: ->
      language = if not Meteor.isClient then Meteor.user().profile.language
      return TAPi18n.__ 'language', {}, language
    custom: () ->
      if not TAPi18n.getLanguages()[@value]?
        language = if not Meteor.isClient then Meteor.user().profile.language
        return TAPi18n.__ 'invalidLanguage', {}, language
