@i18n =
  setLanguage: (language) ->
    TAPi18n.setLanguage language
    T9n.setLanguage language
    languageFromSession = Session.get 'language'

    Session.set 'language', language
    return

  getLanguage: ->
    languages = TAPi18n.getLanguages()
    language = TAPi18n.getLanguage()
    return languages[language]

Meteor.startup ->
  language = currentUserLanguage()

  if not language
    # detect the language used by the browser
    language = window.navigator.userLanguage || window.navigator.language

  i18n.setLanguage language
