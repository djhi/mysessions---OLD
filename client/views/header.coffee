Template.header.events
  # Hide the navbar when links and buttons are clicked if the navbar is
  # displayed as a dropdown menu (on mobile)
  'click.nav .navbar-collapse.in': (event, template) ->
    navbar = template.$ event.currentTarget
    target = template.$ event.target

    if (target.is 'a' || target.is 'button') and target.is ':not(.dropdown-toggle)' then navbar.collapse 'hide'

  'click .btn-set-language': (event, template) ->
    event.preventDefault()
    i18n.setLanguage @code
    return false

  'click .btn-sign-out': (event, template) ->
    event.preventDefault()
    Meteor.logout (error) ->
      if error
        console.log error
        Notifications.error '', TAPi18n._ 'anErrorOccured'
      else
        Router.go 'home'

    return false

Template.header.helpers
  currentLanguage: ->
    return i18n.getLanguage().name

  languages: ->
    return _.map TAPi18n.getLanguages(), (language, code) ->
      return code: code, name: language.name, englishName: language.en
