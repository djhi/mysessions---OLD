Meteor.startup ->
  Courses.after.remove (userId, doc) ->
    # Remove all sessions for this course
    Sessions.remove courseId: doc._id

    # Remove all participants for this course
    Participants.remove courseId: doc._id

    return
