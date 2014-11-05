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
  homeRoutePath: '/'

AccountsTemplates.init()
