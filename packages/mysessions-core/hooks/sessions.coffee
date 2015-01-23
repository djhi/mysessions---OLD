Meteor.startup ->
  Sessions.after.insert (userId, doc) ->
    # Get the last session ordered by date
    lastSession = Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length

    return

  Sessions.after.update (userId, doc) ->
    # Get the last session ordered by date
    lastSession = Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length

    return

  Sessions.after.remove (userId, doc) ->
    # Get the last session ordered by date
    lastSession = Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length

    return
