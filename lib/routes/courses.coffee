Router.map ->
  @route 'allCourses',
    path: '/courses'
    waitOn: ->
      return Meteor.subscribe 'mycourses'
    data: ->
      return courses: Collections.Courses.find {}, sort: title: 1

  @route 'newCourse',
    path: '/courses/new'

  @route 'editCourse',
    path: '/courses/:_id/edit'
    waitOn: ->
      return Meteor.subscribe 'course', @params._id
    data: ->
      return course: Collections.Courses.findOne @params._id
