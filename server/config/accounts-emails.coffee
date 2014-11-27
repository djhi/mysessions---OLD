Accounts.emailTemplates.siteName = Meteor.settings.applicationName
Accounts.emailTemplates.from = "#{Meteor.settings.applicationName} <#{Meteor.settings.defaultEmailAddress}>"

Accounts.emailTemplates.enrollAccount.subject = (user) ->
  language = getLanguage user
  return TAPi18n.__ 'emails.enrollAccount.subject', {}, language

Accounts.emailTemplates.enrollAccount.text = (user, url) ->
  url = sanitizeUrl url
  language = getLanguage user
  return TAPi18n.__ 'emails.enrollAccount.text', url: url, language

Accounts.emailTemplates.resetPassword.subject = (user) ->
  language = getLanguage user
  return TAPi18n.__ 'emails.resetPassword.subject', {}, language

Accounts.emailTemplates.resetPassword.text = (user, url) ->
  console.log url
  url = sanitizeUrl url
  console.log url
  language = getLanguage user
  return TAPi18n.__ 'emails.resetPassword.text', url: url, language

Accounts.emailTemplates.verifyEmail.subject = (user) ->
  language = getLanguage user
  return TAPi18n.__ 'emails.verifyEmail.subject', {}, language

Accounts.emailTemplates.verifyEmail.text = (user, url) ->
  url = sanitizeUrl url
  language = getLanguage user
  return TAPi18n.__ 'emails.verifyEmail.text', url: url, language

sanitizeUrl = (url) ->
  return url.replace(/\/\//g, '/').replace('http:/', 'http://')

getLanguage = (user) ->
  return if user and user.profile and user.profile.language then user.profile.language else 'en'
