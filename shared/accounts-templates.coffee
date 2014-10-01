# AccountsTemplates
# ------------------------------------------------------------------------------
AccountsTemplates.configureRoute 'signUp', redirect: '/profile'
AccountsTemplates.configureRoute 'signIn'
AccountsTemplates.configureRoute 'changePwd'
AccountsTemplates.configureRoute 'enrollAccount'
AccountsTemplates.configureRoute 'forgotPwd'
AccountsTemplates.configureRoute 'resetPwd'

AccountsTemplates.configure
  confirmPassword: true
  enablePasswordChange: true
  sendVerificationEmail: true
  showForgotPasswordLink: true
  continuousValidation: true
  showAddRemoveServices: true
  homeRoutePath: '/all'

AccountsTemplates.init()

# AccountsMeld
# ------------------------------------------------------------------------------
AccountsMeld.configure
  askBeforeMeld: true,
  meldDBCallback: (oldUserId, newUserId) ->
    Collections.Courses.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.Sessions.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.Participants.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
    Collections.ReportRecipients.direct.update {userId: oldUserId}, {$set: {userId: newUserId}}, {multi: true}
