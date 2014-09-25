Template.profile.helpers
  schemaProfile: ->
    return Schemas.Profile

  languages: ->
    return _.map TAPi18n.getLanguages(), (language, code) ->
      return value: code, label: language.name

  fullname: ->
    user = Meteor.user()
    if user and user.profile and user.profile.fullname then return user.profile.fullname
    return ''

  currentLanguage: -> return currentUserLanguage()

AutoForm.addHooks 'editProfileForm',
  onSuccess: (operation, result, template) ->
    Notifications.success '', 'Profile enregistré !', timeout: 5000
    Router.go 'allCourses'
    return
    
  onError: (operation, error, template) ->
    Notifications.error '', 'Une erreur est survenue...'
    return
