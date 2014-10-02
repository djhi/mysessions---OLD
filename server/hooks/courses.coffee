Meteor.startup ->
  Collections.Courses.after.remove (userId, doc) ->
    # Remove all sessions for this course
    Collections.Sessions.remove courseId: doc._id

    # Remove all participants for this course
    Collections.Participants.remove courseId: doc._id

    return
