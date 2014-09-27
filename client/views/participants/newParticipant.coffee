AutoForm.addHooks 'newParticipantForm',
  onSuccess: (operation, result, template) ->
    previousRoute = Session.get 'previousRoute'
    if previousRoute
      Router.go previousRoute
    else
      Router.go 'participants', _id: template.data.course._id
    return

Template.newParticipant.helpers
  submitLabel: ->
    return TAPi18n.__ 'add'

Template.newParticipant.rendered = ->
  @$('.datepicker').datepicker
    viewMode: 'years'

  return
