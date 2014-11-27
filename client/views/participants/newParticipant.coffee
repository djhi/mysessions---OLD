AutoForm.addHooks 'newParticipantForm',
  onSuccess: (operation, participantId, template) ->
    $('.course-checkbox:checked').map ->
      courseId = $(@).val()
      Collections.Courses.update courseId, $addToSet: participantsIds: participantId

    previousRoute = Session.get 'previousRoute'
    if previousRoute
      Router.go previousRoute
    else
      course = Session.get 'course'
      Session.set 'course', undefined

      if course
        Router.go 'participants', _id: course._id
      else
        Router.go 'allParticipants'
    return

Template.newParticipant.rendered = ->
  @$('.datepicker').datepicker
    viewMode: 'years'

  Session.set 'course', @data.course
  return

Template.newParticipant.helpers
  checked: ->
    course = Template.instance().data.course
    if course and course._id is @_id then return checked: 'checked'
