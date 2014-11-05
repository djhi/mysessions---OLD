# Get the global context
g = @

Meteor.startup ->
  # override underscore
  g._ = lodash
