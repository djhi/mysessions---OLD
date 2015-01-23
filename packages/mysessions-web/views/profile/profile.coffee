Template.profile.helpers
  schemaProfile: ->
    return Profile

  languages: ->
    return _.map TAPi18n.getLanguages(), (language, code) ->
      return value: code, label: language.name

  fullname: ->
    user = Meteor.user()
    if user and user.profile and user.profile.fullname
      return user.profile.fullname
      
    return ''

  currentLanguage: -> return i18n.getLanguageCode()

AutoForm.addHooks 'editProfileForm',
  onSuccess: (operation, result, template) ->
    Notifications.success()
    Router.go 'allCourses'
    return

  onError: (operation, error, template) ->
    Notifications.error()
    return
