AutoForm.addHooks 'newParticipantForm',
  onSuccess: (operation, participantId, template) ->
    $('.course-checkbox:checked').map ->
      courseId = $(@).val()
      Collections.Courses.update courseId, $addToSet: participantsIds: participantId

    previousRoute = Session.get 'previousRoute'
    if previousRoute
      Router.go previousRoute
    else
      Router.go 'participants', _id: template.data.course._id
    return

Template.newParticipant.rendered = ->
  @$('.datepicker').datepicker
    viewMode: 'years'

  return

Template.newParticipant.helpers
  checked: ->
    course = Template.instance().data.course
    if course and course._id is @_id then return checked: 'checked'
