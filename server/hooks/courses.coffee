Meteor.startup ->
  Collections.Courses.after.remove (userId, doc) ->
    # Remove all sessions for this course
    Collections.Sessions.remove courseId: doc._id

    # Remove all participants for this course
    Collections.Participants.remove courseId: doc._id

    return

  Collections.Courses.after.update (userId, doc) ->
    participants = Collections.Participants.find courseId: doc._id

    Collections.Courses.direct.update {_id: doc._id}, $set: participantsCount: participants.count()
    return
