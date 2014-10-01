AutoForm.addHooks 'editParticipantForm',
  onSuccess: (operation, result, formId) ->
    Router.go Session.get 'previousRoute'
    return

Template.editParticipant.rendered = ->
  @$('.datepicker').datepicker
    viewMode: 'years'
