Meteor.methods
  updateProfile: (profile) ->
    check profile.fullname, String

    check profile.language, Match.Where (language) ->
      return TAPi18n.getLanguages()[language]?

    return Meteor.users.update @userId, $set: profile: profile
