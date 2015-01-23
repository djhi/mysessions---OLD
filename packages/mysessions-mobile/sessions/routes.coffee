Router.map ->
  @route 'sessions',
    path: '/course/:_id/sessions'
    waitOn: ->
      return [
        Meteor.subscribe 'course', @params._id
        Meteor.subscribe 'sessions', @params._id
      ]
    data: ->
      if @ready()
        return {
          course: Courses.findOne @params._id
          sessions: Sessions.find
            courseId:@params._id
          ,
            sort: date: -1
        }
