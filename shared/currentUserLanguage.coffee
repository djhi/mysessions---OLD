@currentUserLanguage = ->
  user = Meteor.user()
  if user and user.profile and user.profile.language then return user.profile.language
  return Session.get 'language'
