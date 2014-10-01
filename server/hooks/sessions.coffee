Meteor.startup ->
  Collections.Sessions.after.insert (userId, doc, fieldNames, modifier, options) ->
    # Get the last session ordered by date
    lastSession = Collections.Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Collections.Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length

  Collections.Sessions.after.update (userId, doc, fieldNames, modifier, options) ->
    # Get the last session ordered by date
    lastSession = Collections.Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Collections.Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length

  Collections.Sessions.after.remove (userId, doc, fieldNames, modifier, options) ->
    # Get the last session ordered by date
    lastSession = Collections.Sessions.findOne
      courseId: doc.courseId
    ,
      sort: date: -1

    # Update the course last session
    Collections.Courses.direct.update
      _id: doc.courseId
    ,
      $set:
        lastSession:
          date: lastSession.date
          participantsCount: lastSession.participantsIds.length
