if Meteor.isClient
  class i18n
    constructor: ->
      self = @
      self.language = 'fr'

      # Track the current user
      Tracker.autorun ->
        user = Meteor.user()

        # If she specified a prefered language, use it
        if user and user.profile and user.profile.language
          self.language = user.profile.language

        # If not specified, try to detect it from browser
        if not self.language
          # detect the language used by the browser
          self.language = window.navigator.userLanguage || window.navigator.language

        self.setLanguage self.language

    setLanguage: (code) ->
      TAPi18n.setLanguage code
      T9n.setLanguage code
      moment.locale code
      return

    getLanguage: ->
      languages = TAPi18n.getLanguages()
      language = TAPi18n.getLanguage()
      return languages[language]

    getLanguageCode: ->
      return TAPi18n.getLanguage()

  Meteor.startup ->
    window.i18n = new i18n
