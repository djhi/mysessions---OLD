Router.map ->
  @route 'home',
    path: '/'
    waitOn: ->
      return Meteor.subscribe 'mycourses'
    data: ->
      return courses: Collections.Courses.find {}, sort: title: 1

  @route 'profile',
    path: '/profile'

  @route 'notFound',
    path: '*'
    where: 'server'
    action: ->
      @response.statusCode = 404
      @response.end Handlebars.templates['404']()
