Meteor.startup ->
  window.i18n = new i18nHelper()

  AutoForm.setDefaultTemplate 'ionic'
