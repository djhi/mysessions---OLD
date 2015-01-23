ParticipantsController = RouteController.extend
  template: 'participants'
  increment: 50
  limit: -> return parseInt(@params.postsLimit) || @increment
  findOptions: -> return sort: {name: 1}, limit: @limit()
  filters: ->
    course = Courses.findOne @params._id
    return _id: $in: course.participantsIds or []
  participants: -> return Participants.find @filters(), @findOptions()
  nextPathOptions: -> return limit: @limit() + @increment
  nextPathFilters: -> return undefined
  waitOn: ->
    return [
      Meteor.subscribe 'course', @params._id
      Meteor.subscribe 'participants', @params._id, @limit()
    ]
  data: ->
    if @ready()
      hasMore = @participants().count() is @limit()
      nextPath = @route.path @nextPathFilters(), @nextPathOptions()

      return {
        participants: @participants()
        nextPath: nextPath
        course: Courses.findOne @params._id
      }

AllParticipantsController = ParticipantsController.extend
  template: 'allParticipants'
  filters: -> return {}
  nextPathFilters: -> return course: @params._id
  waitOn: ->
    return [
      Meteor.subscribe 'participants', undefined, @limit()
    ]

  data: ->
    if @ready()
      hasMore = @participants().count() is @limit()
      nextPath = @route.path @nextPathFilters(), @nextPathOptions()

      return {
        participants: @participants()
        nextPath: nextPath
      }

Router.map ->
  @route 'newParticipant',
    path: '/participants/new'
    waitOn: ->
      return [
        Meteor.subscribe 'mycourses'
      ]
    data: ->
      return {
        courses: Courses.find {}, sort: title: 1
      }

  @route 'newParticipantForCourse',
    template: 'newParticipant'
    path: '/courses/:_id/participants/new'
    waitOn: ->
      return [
        Meteor.subscribe 'mycourses'
      ]
    data: ->
      return {
        course: Courses.findOne @params._id
        courses: Courses.find {}, sort: title: 1
      }

  @route 'newParticipantFromExisting',
    path: '/courses/:_id/participants/new-from-existing'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
      ]
    data: ->
      return {
        course: Courses.findOne @params._id
      }

  @route 'editParticipant',
    path: '/participants/:_id/edit'
    waitOn: ->
      return [
        Meteor.subscribe 'participant', @params._id
        Meteor.subscribe 'mycourses'
      ]
    data: ->
      return {
        courses: Courses.find {}, sort: title: 1
        participant: Participants.findOne @params._id
      }

  @route 'participants',
    path: '/courses/:_id/participants:limit?'
    controller: ParticipantsController

  @route 'allParticipants',
    path: '/participants/:limit?'
    controller: AllParticipantsController

  @route 'participant',
    path: '/courses/:courseId/participants/:_id'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participant', @params._id
      ]
    data: ->
      return {
        course: Courses.findOne @params.courseId
        participant: Participants.findOne @params._id
      }
