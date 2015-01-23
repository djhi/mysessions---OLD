Router.map ->
  @route 'courses',
    path: '/courses'
    waitOn: ->
      return Meteor.subscribe 'mycourses'
    data: ->
      return courses: Courses.find {}, sort: title: 1

  @route 'newCourse',
    path: '/courses/new'
    data: ->
      return {}

  @route 'editCourse',
    path: '/courses/:_id/edit'
    waitOn: ->
      return Meteor.subscribe 'course', @params._id
    data: ->
      return course: Courses.findOne @params._id
