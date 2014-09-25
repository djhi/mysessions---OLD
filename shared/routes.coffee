Router.map ->
  @route 'home',
    path: '/'

  @route 'profile',
    path: '/profile'

  @route 'allCourses',
    path: '/all'
    waitOn: ->
      return Meteor.subscribe 'mycourses'
    data: ->
      return courses: Collections.Courses.find()

  @route 'newCourse',
    path: '/course/new'

  @route 'editCourse',
    path: '/course/:_id/edit'
    waitOn: ->
      return Meteor.subscribe 'course', @params._id
    data: ->
      return course: Collections.Courses.findOne @params._id

  @route 'course',
    template: 'participants'
    path: '/course/:_id'
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

  @route 'editParticipant',
    path: '/partipants/:_id/edit'
    waitOn: ->
      return Meteor.subscribe 'participant', @params._id
    data: ->
      return participant: Collections.Participants.findOne @params._id

  @route 'newSession',
    path: '/course/:_id/sessions/new'
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
    path: '/course/:courseId/sessions/:_id/edit'
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
    path: '/course/:courseId/sessions/:_id'
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
