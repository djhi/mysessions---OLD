AutoForm.addHooks 'editParticipantForm',
  onSuccess: (operation, result, formId) ->
    if Session.get 'previousRoute'
      Router.go Session.get 'previousRoute'
    return

Template.editParticipant.rendered = ->
  @$('.datepicker').datepicker
    viewMode: 'years'

Template.editParticipant.helpers
  subscribed: () ->
    course = @
    participant = Template.instance().data.participant

    return _.find course.participantsIds, (id) ->
      return id is participant._id

Template.editParticipant.events
  'click .btn-subscribe': (event, template) ->
    event.preventDefault()
    participant = Template.instance().data.participant

    Collections.Courses.update @_id, $addToSet: participantsIds: participant._id

    return false

  'click .btn-unsubscribe': (event, template) ->
    event.preventDefault()
    participant = Template.instance().data.participant

    Collections.Courses.update @_id, $pull: participantsIds: participant._id

    return false
