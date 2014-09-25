# Lazy initialization of namespaces
@Schemas = @Schemas or {}

@Schemas.Profile = new SimpleSchema
  fullname:
    type: String
    label: ->
      user = Meteor.user()
      if Meteor.isServer and user.profile and user.profile.language
        language =  user.profile.language

      return TAPi18n.__ 'fullname', {}, language
    min: 3
    max: 200

  language:
    type: String
    label: ->
      user = Meteor.user()
      if Meteor.isServer and user.profile and user.profile.language
        language =  user.profile.language

      return TAPi18n.__ 'language', {}, language
    custom: () ->
      if not TAPi18n.getLanguages()[@value]? then return 'invalid language'
