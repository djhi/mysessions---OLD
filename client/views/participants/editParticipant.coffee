AutoForm.addHooks 'editParticipantForm',
  onSuccess: (operation, result, formId) ->
    Router.go Session.get 'previousRoute'
