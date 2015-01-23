Router.map ->
  @route 'home',
    path: '/'
    onBeforeAction: ->
      if !!Meteor.user() then @redirect('/courses')
      @next()
      return
    data: ->
      return {}
