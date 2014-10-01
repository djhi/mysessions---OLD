 Meteor.startup ->
  Collections.Participants.after.insert (userId, doc, fieldNames, modifier, options) ->
    Collections.Courses.direct.update {_id: doc.courseId}, $inc: participantsCount: 1
    return

  Collections.Participants.after.remove (userId, doc, fieldNames, modifier, options) ->
    Collections.Courses.direct.update {_id: doc.courseId}, $inc: participantsCount: -1
    return
