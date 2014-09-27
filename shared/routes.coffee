Router.map ->
  @route 'home',
    path: '/'

  @route 'profile',
    path: '/profile'

  @route 'allCourses',
    path: '/courses'
    waitOn: ->
      return Meteor.subscribe 'mycourses'
    data: ->
      return courses: Collections.Courses.find()

  @route 'newCourse',
    path: '/courses/new'

  @route 'editCourse',
    path: '/courses/:_id/edit'
    waitOn: ->
      return Meteor.subscribe 'course', @params._id
    data: ->
      return course: Collections.Courses.findOne @params._id

  @route 'participants',
    template: 'participants'
    path: '/courses/:_id/participants'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
        Meteor.subscribe 'participants', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params._id
        participants: Collections.Participants.find {courseId: @params._id}, {sort: name: 1}
      }

  @route 'newParticipant',
    path: '/courses/:_id/participants/new'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params._id
      }

  @route 'editParticipant',
    path: '/courses/:courseId/participants/:_id/edit'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participant', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params.courseId
        participant: Collections.Participants.findOne @params._id
      }

  @route 'participant',
    path: '/courses/:courseId/participants/:_id'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participant', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params.courseId
        participant: Collections.Participants.findOne @params._id
      }

  @route 'newSession',
    path: '/courses/:_id/sessions/new'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
        Meteor.subscribe 'participants', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params._id
        participants: Collections.Participants.find {courseId: @params._id}, {sort: name: 1}
      }

  @route 'editSession',
    path: '/courses/:courseId/sessions/:_id/edit'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participants', @params.courseId
        Meteor.subscribe 'session', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params.courseId
        session: Collections.Sessions.findOne @params._id
        participants: Collections.Participants.find {courseId: @params.courseId}, {sort: name: 1}
      }

  @route 'session',
    path: '/courses/:courseId/sessions/:_id'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participants', @params.courseId
        Meteor.subscribe 'session', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params.courseId
        session: Collections.Sessions.findOne @params._id
        participants: Collections.Participants.find {courseId: @params.courseId}, {sort: name: 1}
      }

  @route 'sendSessionReport',
    path: '/course/:courseId/sessions/:_id/send-report'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params.courseId
        Meteor.subscribe 'participants', @params.courseId
        Meteor.subscribe 'session', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params.courseId
        session: Collections.Sessions.findOne @params._id
        participants: Collections.Participants.find {courseId: @params.courseId}, {sort: name: 1}
      }

  @route 'sessions',
    path: '/course/:_id/sessions'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
        Meteor.subscribe 'sessions', @params._id
      ]
    data: ->
      return {
        course: Collections.Courses.findOne @params._id
        sessions: Collections.Sessions.find courseId:@params._id
      }

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end Handlebars.templates['404']()
