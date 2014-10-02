Future = Npm.require 'fibers/future'

Meteor.methods
  getGoogleContacts: (filter) ->
    googleConfiguration = ServiceConfiguration.configurations.findOne service: 'google'
    if not googleConfiguration
      console.error 'Google integration is not configured'
      throw new Meteor.Error 503, 'Google integration is not configured'

    user = Meteor.user()
    if not user
      console.error 'no user'
      throw new Meteor.Error 401

    userGoogleConfiguration = user.services.google if user.services
    if not userGoogleConfiguration
      console.error 'user is not connected to Google'
      throw new Meteor.Error 503, 'user is not connected to Google'

    googleContactsConfiguration =
      email: userGoogleConfiguration.email
      consumerKey: googleConfiguration.clientId
      consumerSecret: googleConfiguration.secret
      token: userGoogleConfiguration.accessToken
      refreshToken: userGoogleConfiguration.refreshToken

    gcontacts = new GoogleContacts googleContactsConfiguration

    accessToken = gcontacts.refreshAccessToken googleContactsConfiguration.refreshToken
    gcontacts.token = accessToken

    contacts = gcontacts.getContacts(filter)

    return contacts
