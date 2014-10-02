Router.map ->
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
        Meteor.subscribe 'recipients'
      ]
    data: ->
      if @ready()
        session = Collections.Sessions.findOne @params._id
        course = session.course()
        participants = course.participants()
        sessionReport = session.getDefaultReport()

        return {
          course: course
          session: session
          recipients: Collections.ReportRecipients.find {}
          sessionReport: sessionReport
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
        sessions: Collections.Sessions.find {courseId:@params._id}, sort: date: -1
      }
