Template.header.events
  'click .btn-set-language': (event, template) ->
    event.preventDefault()
    i18n.setLanguage @code
    return false
  'click .btn-sign-out': (event, template) ->
    event.preventDefault()
    Meteor.logout (error) ->
      if error
        #console.log error
        Notifications.error '', 'Une erreur est survenue...'
      else
        Router.go 'home'

    return false

Template.header.helpers
  currentLanguage: ->
    return i18n.getLanguage().name

  languages: ->
    return _.map TAPi18n.getLanguages(), (language, code) ->
      return code: code, name: language.name, englishName: language.en
