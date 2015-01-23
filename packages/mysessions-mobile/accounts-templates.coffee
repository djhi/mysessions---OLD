AccountsTemplates.configureRoute 'signIn', redirect: '/'
AccountsTemplates.configureRoute 'signUp', redirect: '/profile'
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
  homeRoutePath: '/'
  negativeValidation: false
  negativeFeedback: false
  positiveValidation: false
  positiveFeedback: false
