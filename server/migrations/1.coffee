Migrations.add
  version: 1,
  up: ->
    # We need to upgrade owner property for sessions and participants
    courses = Collections.Courses.find()

    courses.forEach (course) ->
      course.participants().forEach (participant) ->
        Collections.Participants.direct.update {_id: participant._id}, $set: userId: course.userId

      course.sessions().forEach (session) ->
        Collections.Sessions.direct.update {_id: session._id}, $set: userId: course.userId
