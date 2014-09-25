Accounts.emailTemplates.siteName = "Mes séances"
Accounts.emailTemplates.from = "Mes séance <no-reply@mysessions.fr>"

Accounts.emailTemplates.enrollAccount.subject = (user) ->
  fullname = if user and user.profile and user.profile.fullname then user.profile.fullname else undefined

  return "Bienvenue sur Mes séances" + if fullname then ', ' + user.profile.fullname else ''

Accounts.emailTemplates.enrollAccount.text = (user, url) ->
  return "Pour activer votre compte, merci de cliquer sur le lien suivant:\r\n\n" + url

Accounts.emailTemplates.resetPassword.subject = (user) ->
  return "Mes séances - ré-initialisation du mot de passe"

Accounts.emailTemplates.resetPassword.text = (user, url) ->
  return "Pour ré-initialiser du mot de passe, merci de cliquer sur le lien suivant:\r\n\n" + url

Accounts.emailTemplates.verifyEmail.subject = (user) ->
  return "Mes séances - vérification de votre adresse email"

Accounts.emailTemplates.verifyEmail.text = (user, url) ->
  return "Pour valider votre adresse email, merci de cliquer sur le lien suivant:\r\n\n" + url
